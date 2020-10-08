import '../api/base_api.dart';
import '../models/goods_page_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class GoodsApi extends BaseApi{
    Future<GoodsPageResult> pagedList(
      {int pageIndex: 1, int itemsInPage: 10,int storeId}) async {
    var url =
        '${BaseApi.goodsUrl}?ItemsInPage=$itemsInPage&PageNumber=$pageIndex&storeId=$storeId';
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      GoodsPageResult pageResult=GoodsPageResult.fromJson(json.decode(response.body));
      return pageResult;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
GoodsApi goodsApi = new GoodsApi();