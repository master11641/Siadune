import '../models/goods.dart';

class GoodsPageResult{
  final bool hasMore;
  final int page;
  final int total;
  final List<Goods> goodses;
  GoodsPageResult({this.hasMore, this.page, this.total, this.goodses});
  factory GoodsPageResult.fromJson(Map<String, dynamic> parsedJson) {
    return GoodsPageResult(
        hasMore: parsedJson['hasMore'],
        page: parsedJson['page'],
        total: parsedJson['total'],
        goodses: (parsedJson['items'] as List)
            .map((x) => Goods.fromJson(x))
            .toList());
  }
}