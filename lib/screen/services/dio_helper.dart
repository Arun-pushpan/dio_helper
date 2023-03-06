
import 'dart:developer';

import 'package:dio/dio.dart';

class ApiHelper{

  Dio dio=Dio(); //create object

  //compile  time check the value or run time check
  static const  baseUrl="http://13.231.0.197/dev/api/v1";

 Future<Response?> getQuery( String routeurl) async{      // rooturl pass String in this function


   String  url =baseUrl + routeurl;   // combaining baseurl + rooturl    // in this rooturl has no values

 Response response  = await dio.get(url);
 print(response);
 return response;

  }

  Future<Response?> postQuery(String routeurl, dynamic data) async{
   String url =baseUrl + routeurl;

   Response response = await dio.post(url,data: data);
   log(response.data);  ///using print or log
   return response;


  }

}