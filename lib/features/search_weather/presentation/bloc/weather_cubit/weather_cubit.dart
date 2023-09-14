import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../../../../core/shared/di/injection.dart';
import '../../../data/data_source/local/isar_database/set_get_from_local.dart';
import '../../../data/models/weather_details_model.dart';
import '../../../domain/use_cases/search_weather_use_case.dart';
import '../../ui/common_widgets/toast.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  WeatherDetailsModel? weatherDetailsModel;
  List<WeatherDetailsModel> userSavedLocationsList = [];

  Future searchLocationWeather({required String locationName}) async {
    emit(SearchLocationRemoteLoading());
    try {
      var permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        List<Location> locations = await locationFromAddress(locationName);
        getWeatherDetails(
            lat: locations.first.latitude.toString(),
            lng: locations.first.longitude.toString());

        // getUserSavedLocations(locationName: locationName);
      }
    } catch (e) {
      getUserSavedLocations(locationName: locationName);
      emit(SearchLocationRemoteFail());
    }
  }

  Future<void> getWeatherDetails({
    required String lat,
    required String lng,
  }) async {
    try {
      SearchWeatherUseCase searchWeatherUseCase = SearchWeatherUseCase(sl());

      weatherDetailsModel = await searchWeatherUseCase.call(lat: lat, lng: lng);
      userSavedLocationsList = await LocalDBController.getSavedLocationList;
      emit(WeatherDataFoundSuccess());
    } catch (e) {
      showSimpleToast(msg: "Error : Try valid name");
      emit(SearchLocationRemoteFail());
    }
  }

  Future getUserSavedLocations({required String locationName}) async {
    emit(GetUserSavedLocationsLoading());
    userSavedLocationsList = await LocalDBController.getSavedLocationList;
    if (userSavedLocationsList.isEmpty) {
      showSimpleToast(msg: "Location is Not Found");
      emit(WeatherDataFoundFail());
    } else {
      try {
        weatherDetailsModel = userSavedLocationsList.firstWhere(
            (element) => element.timezone.toLowerCase().contains(locationName));
        userSavedLocationsList = await LocalDBController.getSavedLocationList;
        emit(WeatherDataFoundSuccess());
      } catch (e) {
        showSimpleToast(msg: "Location is Not Found");
      }
    }
  }

  Future setUserSavedLocations({required String locationName}) async {
    emit(SetUserSavedLocationsLoading());
    userSavedLocationsList = await LocalDBController.getSavedLocationList;
    if (userSavedLocationsList.isEmpty) {
      userSavedLocationsList
          .add(weatherDetailsModel!.copyWith(timezone: locationName));
    } else {
      try {
        final search = userSavedLocationsList.firstWhere((element) =>
            element.lat == weatherDetailsModel!.lat &&
            element.lon == weatherDetailsModel!.lon);
        showSimpleToast(msg: "Location is Saved Before");
      } catch (e) {
        userSavedLocationsList
            .add(weatherDetailsModel!.copyWith(timezone: locationName));
        showSimpleToast(msg: "Location is Saved Success");
      }
    }

    await LocalDBController.setSavedLocationList(userSavedLocationsList);
    emit(SaveLocationSuccess());
  }
}
