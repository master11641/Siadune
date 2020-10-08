import 'package:siadune/models/category.dart';

import '../api/base_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CategoryApi extends BaseApi{
    Future<List<StoreCategory>> getList(
      {int pageIndex: 1, int itemsInPage: 10,int storeId}) async {
    var url =
        'http://persianprogrammer.ir/StoreCategory/GetStoreFirstPage';
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Iterable result = json.decode(response.body);
     // GoodsPageResult pageResult=GoodsPageResult.fromJson(json.decode(response.body));
      List<StoreCategory> cats = result.map((x){
        return StoreCategory.fromJson(x);
      }).toList();
      return cats;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
CategoryApi categoryApi = new CategoryApi();