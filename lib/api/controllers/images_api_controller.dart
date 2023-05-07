import 'dart:convert';
import 'dart:io';

import 'package:api_secand_project/api/api_setting.dart';
import 'package:api_secand_project/helper/api_responce.dart';
import 'package:api_secand_project/models/api_response.dart';
import 'package:api_secand_project/models/studen_image.dart';
import 'package:api_secand_project/storage/shared_pref_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devtool show log;

class ImagesApiController with ApiHeaderResponse {
  Future<List<StudentImage>> getImages() async {
    Uri uri = Uri.parse(ApiSetting.images.replaceFirst('/{id}', ''));
    devtool.log('uri= $uri');
    var response = await http.get(uri, headers: header);
    devtool.log('status code images =${response.statusCode}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray
          .map((studentImageJsonObject) =>
              StudentImage.fromJson(studentImageJsonObject))
          .toList();
    }
    return [];
  }

  Future<ApiResponse> deleteImage({required int id}) async {
    Uri uri = Uri.parse(ApiSetting.images.replaceFirst('{id}', id.toString()));
    var response = await http.delete(uri, headers: header);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
        status: jsonResponse['status'],
        message: jsonResponse['message'],
      );
    } else if (response.statusCode == 404) {
      return ApiResponse(status: false, message: 'Image Not found');
    } else {
      return ApiResponse(status: false, message: 'Some thing went wrong');
    }
  }

  Future<http.StreamedResponse> uploadImage({required String path}) async {
    Uri uri = Uri.parse(ApiSetting.images.replaceFirst('/{id}', ''));
    var request = http.MultipartRequest('POST', uri);
    var imageFile = await http.MultipartFile.fromPath('image', path);
    request.files.add(imageFile);
    request.headers[HttpHeaders.authorizationHeader] =
        SharedPrefController().getValue<String>(key: PrefKeys.token.name)!;
    request.headers[HttpHeaders.acceptHeader] = 'application/json';

    var response = await request.send();
    devtool.log(response.toString());
    // response.stream.transform(utf8.decoder).listen((String body) { });
    return response;
  }
// Future<void> uploadImage()async{}
}
