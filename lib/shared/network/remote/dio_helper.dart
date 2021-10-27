import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
        BaseOptions(
            baseUrl: 'https://student.valuxapps.com/api/',
            receiveDataWhenStatusError: true
        ));
  }

  static Future<Response> postData(
      {
        @required String path,
        Map<String, dynamic> query,
        @required Map<String, dynamic> data,
        String token, String lang
      }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? ''
    };
    return await dio.post(path, queryParameters: query, data: data);
  }

  static Future<Response> getData(
      {
        @required String path,
        Map<String, dynamic> query,
        String token,
        String lang
      }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? ''
    };
    return await dio.get(path, queryParameters: query);
  }
}
