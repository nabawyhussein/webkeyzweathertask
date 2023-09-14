import 'dart:convert';
import 'package:dio/dio.dart';
import '../api_path_controller.dart';

class APIClient {
  static final  dio = Dio();
  static Future<Response> getDataWithDio(
      {String? path, dynamic data, String? token}) async {
    Response response = await dio.get(ApiPaths.baseUrl + path!,
        options: Options(
          method: 'GET',
          responseType: ResponseType.json,
        ));
    if (response.statusCode == 200) {
      print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }
    return response;
  }
}
