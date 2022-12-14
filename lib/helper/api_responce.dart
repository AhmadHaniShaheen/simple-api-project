import 'dart:io';

import 'package:api_secand_project/storage/sharedPrefController.dart';

mixin ApiHeaderResponse{


  Map<String,String> get header{
    return {
      HttpHeaders.authorizationHeader: SharedPrefController().getValue<String>(key: prefKeys.token.name)!,
      HttpHeaders.acceptHeader: 'application/json'
    };
  }
}