import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/src/media_type.dart';
import '../api/base_api.dart';
import 'package:path/path.dart';

Future<String> uploadFile(File file) async {
  var uri = Uri.parse("http://tagweb.ir/api/DocumentUpload/MediaUpload");
  var request = new http.MultipartRequest("POST", uri);
  request.fields['ClientDocs'] = 'ClientDocs';
//request.files.add(http.MultipartFile.fromPath('Image', 'filePath'))
  request.files.add(await http.MultipartFile.fromPath('Image', file.path,
      contentType: new MediaType('application', 'x-tar')));
  var response = await request.send();
  if (response.statusCode == 200) {
    return '${BaseApi.baseUrl}/Upload/Images/ClientDocument/${basename(file.path)}';
  } else {
    throw Exception('error to upload image!');
  }
}
