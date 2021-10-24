import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(BaseOptions(baseUrl: 'https://student.valuxapps.com/api/', receiveDataWhenStatusError: true, headers: {
      'Content-Type': 'application/json',
      'lang': 'en',
    }));
  }

  static Future<void> postData(
      {@required String path, Map<String, dynamic> query, @required Map<String, dynamic> data, String token, String lang}) async {
    dio.options.headers = {'Content-Type': 'application/json', 'lang': lang, 'Authorization': token};
    return await dio.post(path, queryParameters: query, data: data);
  }
}
