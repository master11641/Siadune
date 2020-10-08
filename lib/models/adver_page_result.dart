import '../models/adver.dart';

class AdverPageResult {
  final bool hasMore;
  final int page;
  final int total;
  final List<Adver> advers;
  AdverPageResult({this.hasMore, this.page, this.total, this.advers});
  factory AdverPageResult.fromJson(Map<String, dynamic> parsedJson) {
    return AdverPageResult(
        hasMore: parsedJson['hasMore'],
        page: parsedJson['page'],
        total: parsedJson['total'],
        advers: (parsedJson['items'] as List)
            .map((x) => Adver.fromJSON(x))
            .toList());
  }
}
