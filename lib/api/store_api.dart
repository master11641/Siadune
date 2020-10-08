import '../api/base_api.dart';
import '../models/adver_page_result.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/store_page_result.dart';

class StoreApi extends BaseApi {
  Future<StorePageResult> pagedList(
      {int pageIndex: 1, int itemsInPage: 10}) async {
    var url =
        '${BaseApi.storeUrl}?ItemsInPage=$itemsInPage&PageNumber=$pageIndex';
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var result = StorePageResult.fromJson(json.decode(response.body));
      return result;
    } else {
      throw Exception('Failed to load post');
    }
  }
  Future<StorePageResult> storeCategorizedpagedList(
      {int pageIndex: 1, int itemsInPage: 10,int catId,int cityId}) async {
    var url =
        'http://persianprogrammer.ir/Stores/GetStoresByCategoryId?ItemsInPage=$itemsInPage&PageNumber=$pageIndex&cityId=$cityId&categoryId=$catId';
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var result = StorePageResult.fromJson(json.decode(response.body));
      return result;
    } else {
      throw Exception('Failed to load post');
    }
  }

}

StoreApi storeApi = StoreApi();
