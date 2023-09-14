import '../../data/models/weather_details_model.dart';
import '../entities/weather_details_entity.dart';
import '../repo/repo_abstract.dart';

class SearchWeatherUseCase {
  RepoBase repo;

  SearchWeatherUseCase(this.repo);

  Future<WeatherDetailsModel> call({
    required String lat,
    required String lng,
  } ) async {
    return await repo.getWeatherDetails(lat: lat, lng: lng);
    }
}