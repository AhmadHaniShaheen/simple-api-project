import 'dart:convert';
import 'dart:io';

import 'package:api_secand_project/api/api_setting.dart';
import 'package:api_secand_project/helper/api_responce.dart';
import 'package:api_secand_project/models/api_response.dart';
import 'package:api_secand_project/models/strudent.dart';
import 'package:api_secand_project/storage/sharedPrefController.dart';
import 'package:http/http.dart' as http;



class StudentAuthApiController with ApiHeaderResponse{

  Future<ApiResponse> login({required String email,required String password})async{
    var uri=Uri.parse(ApiSetting.login);
    var response=await http.post(uri,body: {
      'email': email,
      'password':password
    });

    if(response.statusCode==200||response.statusCode==400){
      var jsonResponse=jsonDecode(response.body);
     if(response.statusCode==200){
       var jsonObject=jsonResponse['object'];
       Student student=Student.fromJson(jsonObject);
       await SharedPrefController().save(student: student);
     }
      return ApiResponse(status: jsonResponse['status'], message: jsonResponse['message']);
    }else{
      return ApiResponse(status: false, message: 'Some thing went wrong');
    }
  }
  Future<ApiResponse> register(Student student)async{
    Uri uri=Uri.parse(ApiSetting.register);
    var response=await http.post(uri, body: {
      'full_name':student.fullName,
      'email':student.email,
      'password':student.password,
      'gender':student.fullName,
    });
    if(response.statusCode==201||response.statusCode==400){
      var jsonResponse=jsonDecode(response.body);
      return ApiResponse(status: jsonResponse['status'], message: jsonResponse['message']);
    }
    else{
      return ApiResponse(status: false, message: 'Some thing went wrong');
    }
  }


  Future<ApiResponse> forgetPassword({required String email})async{
    Uri uri=Uri.parse(ApiSetting.forgetPassword);
    var response=await http.post(uri,body: {
      'email':email,
    });
    if(response.statusCode==200||response.statusCode==400){
      var jsonResponse=jsonDecode(response.body);
      if(response.statusCode==200){
        print('Code: ${jsonResponse['code']}');
      }
      return ApiResponse(status: jsonResponse['status'], message: jsonResponse['message']);
    }else{
      print('big error');
      return ApiResponse(status: false, message: 'server handel error');
    }
  }
  Future<ApiResponse> restPassword({required String email,required String password, required String code})async{
    Uri uri=Uri.parse(ApiSetting.resetPassword);
    var response=await http.post(uri,body: {
      'email':email,
      'password':password,
      'password_confirmation':password,
      'code':code,
    });
    if(response.statusCode==200||response.statusCode==400){
      var jsonResponse=jsonDecode(response.body);
      return ApiResponse(status: jsonResponse['status'], message: jsonResponse['message']);
    }else{
      print('big error');
      return ApiResponse(status: false, message: 'server handel error');
    }
  }


  Future<ApiResponse> logout()async{
    Uri uri=jsonDecode(ApiSetting.logout);
    var response=await http.get(uri,headers: header);
    if(response.statusCode==200||response.statusCode==401){
      await SharedPrefController().clear();
      if(response.statusCode==200){
      var jsonResponse=jsonDecode(response.body);
        return ApiResponse(status: jsonResponse['status'], message: jsonResponse['message']);
      }
      return ApiResponse(status: true, message: 'logged out successfully');

    }
    else{
      return ApiResponse(status: false, message: 'some thing went wrong');
    }
  }

}