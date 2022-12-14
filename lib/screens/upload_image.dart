import 'dart:io';

import 'package:api_secand_project/get/images_getx_controller.dart';
import 'package:api_secand_project/models/api_response.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  late ImagePicker _imagePicker;
  XFile? _pickedImage;

  double? _progressValue = 0;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
        actions: [
          Icon(Icons.camera),
          SizedBox(
            width: 8,
          )
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 10,
            color: Colors.green,
            value: _progressValue,
          ),
          _pickedImage == null
              ? Expanded(
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        _pickerImage();
                      },
                      icon: Icon(
                        Icons.camera_enhance,
                        size: 32,
                      ),
                    ),
                  ),
                )
              : Expanded(child: Image.file(File(_pickedImage!.path))),
          ElevatedButton.icon(
            onPressed: () async {
              await preformUpload();
            },
            icon: Icon(Icons.upload),
            label: Text('Upload'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  void _pickerImage() async {
    XFile? _selectedImage = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 80);
    if (_selectedImage != null) {
      setState(() {
        _pickedImage = _selectedImage;
      });
    }
  }

  Future<void> preformUpload() async {
    if (_checkData()) {
      await uploadImage();
      print('is thire any image? ${_pickedImage}');
    }
  }

  bool _checkData() {
    if (_pickedImage != null) {
      return true;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Upload image failed')));
    return false;
  }

  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> uploadImage() async {
    setState(() {
      _progressValue = null;
    });

    ImagesGetxController.to.uploadImage(
        path: _pickedImage!.path,
        uploadImageCallBack: ({required ApiResponse apiResponse}) {
          setState(() {
            _progressValue = apiResponse.status ? 1 : 0;
          });
          print('here is the status code == ${apiResponse.status}');
          showSnackBar(
              message: apiResponse.message, error: !apiResponse.status);
        });
  }
}
