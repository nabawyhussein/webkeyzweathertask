import '../../data/models/weather_details_model.dart';
import '../repo/repo_abstract.dart';

class SearchWeatherUseCase {
  RepoBase repo;

  SearchWeatherUseCase(this.repo);

  Future<WeatherDetailsModel> call({
    required String lat,
    required String lng,
  }) async {
    return await repo.getWeatherDetails(lat: lat, lng: lng);
  }
}
