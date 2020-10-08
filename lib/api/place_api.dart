import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siadune/models/place_response.dart';

Future<PlaceResponse> getPlace(double longtude, double latitude) async {
  http.Response response = await http.get(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/$longtude,$latitude.json?access_token=pk.eyJ1IjoibWFzdGVyMTE2NDEiLCJhIjoiY2tkYWR1NDNkMGN5MTJxbXoydDZoaWFiYyJ9.sp3sVaNqQP8UJ6BAh2lmpA');
  print(response.body);
  PlaceResponse placeResponse = PlaceResponse.fromJson(json.decode(response.body));
  return placeResponse;
}
Future<dynamic> getPlace1(double longtude, double latitude) async {
  http.Response response = await http.get(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/56.9162010334085,33.59351874014358.json?types=poi&access_token=pk.eyJ1IjoibWFzdGVyMTE2NDEiLCJhIjoiY2tkYWR1NDNkMGN5MTJxbXoydDZoaWFiYyJ9.sp3sVaNqQP8UJ6BAh2lmpA');
  print(response.body);
}
