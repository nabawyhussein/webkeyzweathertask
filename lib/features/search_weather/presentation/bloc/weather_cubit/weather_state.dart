part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class SearchLocationRemoteSuccess extends WeatherState {}

class SearchLocationLoading extends WeatherState {}

class SearchLocationRemoteFail extends WeatherState {}

class WeatherDataFoundFail extends WeatherState {}

class WeatherDataFoundSuccess extends WeatherState {}

class SaveLocationSuccess extends WeatherState {}

class GetUserSavedLocationsSuccess extends WeatherState {}
