import '../models/adver.dart';
import '../models/store.dart';

class StorePageResult {
  final bool hasMore;
  final int page;
  final int total;
  final List<Store> stores;
  StorePageResult({this.hasMore, this.page, this.total, this.stores});
  factory StorePageResult.fromJson(Map<String, dynamic> parsedJson) {
    return StorePageResult(
        hasMore: parsedJson['hasMore'],
        page: parsedJson['page'],
        total: parsedJson['total'],
        stores: (parsedJson['items'] as List)
            .map((x) => Store.fromJson(x))
            .toList());
  }
}
