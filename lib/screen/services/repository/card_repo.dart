

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tesing/screen/services/dio_helper.dart';

class CardRepo{

  ApiHelper apiHelper = ApiHelper(); // call the baseurl

  static const routeurl="/cards";

  Future<Response?> getCardImage()async {
try {
  Response? response = await apiHelper.getQuery(routeurl);
  print(response);
  if (response!.statusCode == 200) {   //check the response here
    return response;
  }
  else {
    return null;
  }

}catch(e){
 throw Exception(e);
 }



  }

  Future<Response?> postImage(
  String fullName,String email, int phoneNo,String cardType ,File backgroundImage
      ) async{

    try{

      MultipartFile? imageFile;
      var images =File(backgroundImage.path);
      imageFile = await MultipartFile.fromFile(images.path,filename:"arun");
      Map<String,dynamic> data={
        "Email":email,
        "FullName":fullName,
        "PhoneNo":phoneNo,
        "CardType":cardType,
        "BackGroundImage":backgroundImage
      };
      FormData formData =FormData.fromMap(data);  /// convert  data to Formdata

      Response? response =await apiHelper.postQuery(routeurl,data );
      if (response?.statusCode ==200){
        return response;
      }else{
        return null;
      }

    }catch(e){
      throw Exception(e);
    }

  }

}