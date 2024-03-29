import 'dart:io';

import 'package:api_secand_project/storage/shared_pref_controller.dart';

mixin ApiHeaderResponse {
  Map<String, String> get header {
    return {
      HttpHeaders.authorizationHeader:
          SharedPrefController().getValue<String>(key: PrefKeys.token.name)!,
      HttpHeaders.acceptHeader: 'application/json'
    };
  }
}
