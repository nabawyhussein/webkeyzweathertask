part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}
class SearchLocationSuccess extends WeatherState {}
class SearchLocationLoading extends WeatherState {}
class SearchLocationFail extends WeatherState {}
