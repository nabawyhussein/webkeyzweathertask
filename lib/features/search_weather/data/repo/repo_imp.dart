import 'package:webkeys/features/search_weather/domain/entities/weather_details_entity.dart';

import '../../domain/repo/repo_abstract.dart';
import '../data_source/remote/weather_repo.dart';
import '../models/weather_details_model.dart';

class RepoImp  extends RepoBase{
  BaseSearchWeatherRemote baseSearchWeatherRemote;
  RepoImp(this.baseSearchWeatherRemote);
  @override
  Future<WeatherDetailsModel> getWeatherDetails({required String lat, required String lng}) async
  {
    return await baseSearchWeatherRemote.getWeatherDetails(lat: lat, lng: lng);
  }

}