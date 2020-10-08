import 'dart:collection';

import 'package:rxdart/rxdart.dart' as prefix0;
import '../api/adver_api.dart';
import '../blocs/bloc_provider.dart';
import '../models/adver.dart';
import '../models/adver_page_result.dart';
import 'package:rxdart/rxdart.dart';
import '../tools/connectivity-check.dart';

class AdverBloc extends BlocBase {
  NetworkCheck networkCheck = new NetworkCheck();

  ///
  /// Max number of advers per fetched page
  ///
  final int itemsPerPage = 10;

  ///
  /// List of all the adver pages that have been fetched from Internet.
  /// We use a [Map] to store them, so that we can identify the pageIndex
  /// more easily.
  ///
  final _fetchPages = <int, AdverPageResult>{};

  ///
  /// Total number of advers in the catalog
  ///
  int _totalAdvers = -1;

  ///
  /// List of the pages, currently being fetched from Internet
  ///
  final _pagesBeingFetched = Set<int>();

  ///
  /// We are going to need the list of movies to be displayed
  ///
  ReplaySubject<List<Adver>> _aAdversController =
      ReplaySubject<List<Adver>>();
  Sink<List<Adver>> get _inAdversList => _aAdversController.sink;
  Stream<List<Adver>> get outAdversList => _aAdversController.stream;

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
  ReplaySubject<int> _totalAdversController = ReplaySubject<int>();
  Sink<int> get _inTotalAdvers => _totalAdversController.sink;
  Stream<int> get outTotalAdvers => _totalAdversController.stream;
  AdverBloc() {
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
    // _connectionController.stream
    //     .bufferTime(Duration(microseconds: 500))
    //     .where((batch) => batch.isNotEmpty)
    //     .listen(_handleConnection);
    //
    // When filters are changed, we need to consider the changes
    //
    //outFilters.listen(_handleFilters);
  }
  // void _handleConnection(List<bool> connects) {
  //   connects.forEach((bool isConnect) {
  //     if (isConnect) {
  //       inAdverIndex.add((_pagesBeingFetched.length == 0)
  //           ? _pagesBeingFetched.length * 10 + itemsPerPage
  //           : 1);
  //     }
  //   });
  // }

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
            adverApi
                .pagedList(
                  pageIndex: pageIndex,
                  itemsInPage: itemsPerPage,
                )
                .then((AdverPageResult fetchedPage) =>
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
  void _handleFetchedPage(AdverPageResult page, int pageIndex) {
    // Remember the page
    _fetchPages[pageIndex] = page;
    // Remove it from the ones being fetched
    _pagesBeingFetched.remove(pageIndex);

    // Notify anyone interested in getting access to the content
    // of all pages... however, we need to only return the pages
    // which respect the sequence (since MovieCard are in sequence)
    // therefore, we need to iterate through the pages that are
    // actually fetched and stop if there is a gap.
    List<Adver> advers = <Adver>[];
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
        advers.addAll(_fetchPages[i].advers);
      }
    }

    // Take the opportunity to remember the number of movies
    // and notify who might be interested in knowing it
    if (_totalAdvers == -1) {
      _totalAdvers = page.total;
      _inTotalAdvers.add(_totalAdvers);
    }

    // Only notify when there are movies
    if (advers.length > 0) {
      _inAdversList.add(UnmodifiableListView<Adver>(advers));
    }
  }

  @override
  void dispose() {
    _indexController.close();
    _aAdversController.close();
    _totalAdversController.close();
  }
}
