import 'dart:collection';
import '../api/goods_api.dart';
import '../blocs/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../models/goods.dart';
import '../models/goods_page_result.dart';
import '../tools/connectivity-check.dart';

class GoodsBloc extends BlocBase {
  NetworkCheck networkCheck = new NetworkCheck();
  int storeId = 0;

  ///
  /// Max number of advers per fetched page
  ///
  final int itemsPerPage = 10;

  ///
  /// List of all the adver pages that have been fetched from Internet.
  /// We use a [Map] to store them, so that we can identify the pageIndex
  /// more easily.
  ///
  var _fetchPages = <int, GoodsPageResult>{};

  ///
  /// Total number of advers in the catalog
  ///
  int _total = -1;

  ///
  /// List of the pages, currently being fetched from Internet
  ///
  var _pagesBeingFetched = Set<int>();

  ///
  /// We are going to need the list of movies to be displayed
  ///
  PublishSubject<List<Goods>> _mainController = PublishSubject<List<Goods>>();
  Sink<List<Goods>> get _inMainList => _mainController.sink;
  Stream<List<Goods>> get outMainList => _mainController.stream;

  BehaviorSubject<bool> _connectionController =
      BehaviorSubject<bool>.seeded(false);
  Sink<bool> get _inConnectionController => _connectionController.sink;
  Stream<bool> get outConnectionController => _connectionController.stream;

  ///
  /// Each time we need to render a MovieCard, we will pass its [index]
  /// so that, we will be able to check whether it has already been fetched
  /// If not, we will automatically fetch the page
  ///
  PublishSubject<int> _indexController = PublishSubject<int>();
  Sink<int> get inAdverIndex => _indexController.sink;

  ///
  /// Let's put to the limits of the automation...
  /// Let's consider listeners interested in knowing if a modification
  /// has been applied to the filters and total of movies, fetched so far
  ///
  BehaviorSubject<int> _totalAdversController = BehaviorSubject<int>.seeded(0);
  Sink<int> get _inTotalAdvers => _totalAdversController.sink;
  Stream<int> get outTotalAdvers => _totalAdversController.stream;
  GoodsBloc() {
    //
    // As said, each time we will have to render a MovieCard, the latter will send us
    // the [index] of the movie to render.  If the latter has not yet been fetched
    // we will need to fetch the page from the Internet.
    // Therefore, we need to listen to such request in order to handle the request.
    //
    _indexController.stream
        // take some time before jumping into the request (there might be several ones in a row)
        .bufferTime(Duration(microseconds: 500))
        // and, do not update where this is no need
        .where((batch) => batch.isNotEmpty)
        .listen(_handleIndexes);
  }

  void _handleIndexes(List<int> indexes) async {
    bool isConnectionActive = await networkCheck.check();
    _inConnectionController.add(isConnectionActive);
    if (isConnectionActive) {
      // Iterate all the requested indexes and,
      // get the index of the page corresponding to the index
      indexes.forEach((int index) {
        final int pageIndex = 1 + ((index + 1) ~/ itemsPerPage);

        // check if the page has already been fetched
        if (!_fetchPages.containsKey(pageIndex)) {
          // the page has NOT yet been fetched, so we need to
          // fetch it from Internet
          // (except if we are already currently fetching it)
          if (!_pagesBeingFetched.contains(pageIndex)) {
            // Remember that we are fetching it
            _pagesBeingFetched.add(pageIndex);
            // Fetch it
            goodsApi
                .pagedList(
                    pageIndex: pageIndex,
                    itemsInPage: itemsPerPage,
                    storeId: storeId)
                .then((GoodsPageResult fetchedPage) =>
                    _handleFetchedPage(fetchedPage, pageIndex));
          }
        }
      });
    }
  }

  ///
  /// Once a page has been fetched from Internet, we need to
  /// 1) record it
  /// 2) notify everyone who might be interested in knowing it
  ///
  void _handleFetchedPage(GoodsPageResult page, int pageIndex) {
    // Remember the page
    _fetchPages[pageIndex] = page;
    // Remove it from the ones being fetched
    _pagesBeingFetched.remove(pageIndex);

    // Notify anyone interested in getting access to the content
    // of all pages... however, we need to only return the pages
    // which respect the sequence (since MovieCard are in sequence)
    // therefore, we need to iterate through the pages that are
    // actually fetched and stop if there is a gap.
    List<Goods> advers = <Goods>[];
    List<int> pageIndexes = _fetchPages.keys.toList();
    pageIndexes.sort((a, b) => a.compareTo(b));

    final int minPageIndex = pageIndexes[0];
    final int maxPageIndex = pageIndexes[pageIndexes.length - 1];

    // If the first page being fetched does not correspond to the first one, skip
    // and as soon as it will become available, it will be time to notify
    if (minPageIndex == 1) {
      for (int i = 1; i <= maxPageIndex; i++) {
        if (!_fetchPages.containsKey(i)) {
          // As soon as there is a hole, stop
          break;
        }
        // Add the list of fetched movies to the list
        advers.addAll(_fetchPages[i].goodses);
      }
    }

    // Take the opportunity to remember the number of movies
    // and notify who might be interested in knowing it
    if (_total == -1) {
      _total = page.total;
      _inTotalAdvers.add(_total);
    }

    // Only notify when there are movies
    if (advers.length > 0) {
      _inMainList.add(UnmodifiableListView<Goods>(advers));
    }
  }
 bool doesStoreFetchEnded() {
    if (_fetchPages == null || _fetchPages.length == 0) {
      return false;
    }
    return _fetchPages.values.last.hasMore;
  }
  @override
  void dispose() {
    _indexController.close();
    _mainController.close();
    _totalAdversController.close();
  }

  void clearPages() {
    _fetchPages.clear();
    _pagesBeingFetched.clear();
    _total=-1;
  }
}
