import '../../data/models/weather_details_model.dart';
import '../entities/weather_details_entity.dart';

abstract class RepoBase {
  Future<WeatherDetailsModel> getWeatherDetails({
    required String lat,
    required String lng,
  });
}
