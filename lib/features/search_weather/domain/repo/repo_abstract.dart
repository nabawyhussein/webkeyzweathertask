import '../../data/models/weather_details_model.dart';

abstract class RepoBase {
  Future<WeatherDetailsModel> getWeatherDetails({
    required String lat,
    required String lng,
  });
}
