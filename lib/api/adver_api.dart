import '../api/base_api.dart';
import '../models/adver_page_result.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdverApi extends BaseApi {
  Future<AdverPageResult> pagedList(
      {int pageIndex: 1, int itemsInPage: 10}) async {
    var url =
        '${BaseApi.averUrl}?ItemsInPage=$itemsInPage&PageNumber=$pageIndex';
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return AdverPageResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}

AdverApi adverApi = AdverApi();
