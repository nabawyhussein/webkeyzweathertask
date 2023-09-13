import 'dart:convert';

import '../../../shared/resources/constants_manager.dart';
import '../../models/weather_details_model.dart';
import 'api_path_controller.dart';
import 'network/api_helper.dart';

class WeatherRepo {
  static Future<WeatherDetailsModel> getWeatherDetails(
  {
    required String lat,
    required String lng,
}
      ) async {
    final response = await APIClient.getDataWithDio(

      path: 'cnt=5&appid=${ConstantsManager.weatherApiKey}&lat=$lat&lon=$lng',
    );
    return WeatherDetailsModel.fromJson(json.decode(response.toString()));
  }
}