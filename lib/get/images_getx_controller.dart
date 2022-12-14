import 'dart:convert';

import 'package:api_secand_project/api/controllers/images_api_controller.dart';
import 'package:api_secand_project/models/api_response.dart';
import 'package:api_secand_project/models/studen_image.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

typedef UploadImageCollBack = void Function({required ApiResponse apiResponse});

class ImagesGetxController extends GetxController {
  // Typeof UploadImageCollBack=void Function({required ApiResponse apiResponse});

  RxList<StudentImage> images = <StudentImage>[].obs;
  final ImagesApiController _imagesApiController = ImagesApiController();

  static ImagesGetxController get to => Get.find();
  RxBool loading = false.obs;

  @override
  void onInit() {
    getImages();
    super.onInit();
  }

  void getImages() async {
    loading.value = true;
    images.value = await _imagesApiController.getImages();
    loading.value = false;
  }

  Future<ApiResponse> deleteImage({required int index}) async {
    ApiResponse apiResponse =
        await _imagesApiController.deleteImage(id: images[index].id);
    if (apiResponse.status == true) {
      images.removeAt(index);
    }
    return apiResponse;
  }

  Future<void> uploadImage(
      {required String path,
      required UploadImageCollBack uploadImageCallBack}) async {
    StreamedResponse streamedResponse =
        await _imagesApiController.uploadImage(path: path);
    if (streamedResponse.statusCode == 201 ||
        streamedResponse.statusCode == 400) {
      streamedResponse.stream.transform(utf8.decoder).listen((String body) {
        var jsonResponse = jsonDecode(body);
        if (streamedResponse.statusCode == 201) {
          uploadImageCallBack(
              apiResponse: ApiResponse(
                  status: jsonResponse['status'],
                  message: jsonResponse['message']));
          StudentImage studentImage =
              StudentImage.fromJson(jsonResponse['object']);
          images.add(studentImage);
        }
      });
    }else{
      uploadImageCallBack(apiResponse: ApiResponse(status: false, message: 'some thing went wrong'));
    }
  }
}
