import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../api_path_controller.dart';

class APIClient {
  static final dio = Dio();

  static Future<Response> getDataWithDio(
      {String? path, dynamic data, String? token}) async {
    Response response = await dio.get(ApiPaths.baseUrl + path!,
        options: Options(
          method: 'GET',
          responseType: ResponseType.json,
        ));
    if (response.statusCode == 200) {
      debugPrint(json.encode(response.data));
    } else {
      debugPrint(response.statusMessage);
    }
    return response;
  }
}
