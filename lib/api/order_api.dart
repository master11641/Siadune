import 'dart:io';

import 'package:siadune/model/model.dart';
import 'package:siadune/models/order_details.dart';
import 'package:siadune/tools/network_service.dart';

import '../api/base_api.dart';
import 'package:http/http.dart' as http;
import '../models/order_result.dart';
import 'dart:convert';

import '../tools/common_funcs.dart';

class OrderApi extends BaseApi {
  String uri = BaseApi.orderRegisterUrl;
  Future<OrderResult> registerOrder(
      int tgoodsId, int count,int addressId ,List<int> attributeValueIds) async {
    Map<String, String> headers = {"content-type": "application/x-www-form-urlencoded"};
    var cookieHeader = await getAuthenticateHeader();
    print(await User().select().toCount());
    var user = await User().select().toSingle();    
    headers.addAll({HttpHeaders.authorizationHeader: 'Bearer ${user.token}'});
    Map<String, dynamic> body = {
      'TgoodsId': '$tgoodsId',
      'Count': '$count',     
      'AddressId':  '$addressId',
      'longitude': '127',
      'latitude': '127',
      'FullAddress': 'خراسان',      
      'cityId': '10',
    };
    for (var item in attributeValueIds) {
      var attr = {'AttributeValueIds': '${item}'};
        body.addAll(attr);
    }
    final encoding = Encoding.getByName('utf-8');      
    http.Response response =
        await http.post(uri, body: body, headers: headers,encoding: encoding);
    if ((response.statusCode < 200 ||
        response.statusCode >= 400 ||
        json == null)) {
      throw new Exception("Error ");
    }
    return OrderResult.fromJson(json.decode(response.body));
  }

  Future<OrderDetails> getOrderById(String id) async {
    http.Response response = await http.get('${BaseApi.orderDetailsUrl}/$id');
    if ((response.statusCode < 200 ||
        response.statusCode > 400 ||
        json == null)) {
      throw new Exception("Error ");
    }
    return OrderDetails.fromJson(json.decode(response.body));
  }
}

OrderApi orderApi = OrderApi();
