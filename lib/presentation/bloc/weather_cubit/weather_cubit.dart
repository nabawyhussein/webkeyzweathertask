import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as se;

import '../../../data/data_source/remote/weather_repo.dart';
import '../../../data/models/weather_details_model.dart';
import '../../../shared/di/injection.dart';
import '../../../shared/resources/constants_manager.dart';
import '../../../shared/resources/routes_manager.dart';
part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  WeatherDetailsModel? weatherDetailsModel;
  Future searchLocationWeather({
    required String locationName
}) async {
    emit(SearchLocationLoading());
    try{
      var permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {

        List<Location> locations = await locationFromAddress(locationName);
        debugPrint(locations.length.toString());
        debugPrint(locations.first.longitude.toString());
        debugPrint(locations.first.longitude.toString());
        getWeatherDetails(lat: locations.first.latitude.toString(), lng: locations.first.longitude.toString());

        // List<Placemark> placemarks = await placemarkFromCoordinates(
        //     locations.first.latitude
        //     , locations.first.longitude);
        // debugPrint(placemarks.first.name);
        // debugPrint(placemarks.first.street);
        // debugPrint(placemarks.first.country);

      }

    }catch(e){
      emit(SearchLocationFail());
    }
  }

  Future<void> getWeatherDetails({
    required String lat,
    required String lng,
  }) async {
    try {
      weatherDetailsModel = await WeatherRepo.getWeatherDetails
        (lat: lat, lng: lng);

      emit(SearchLocationSuccess());
    } catch (e) {
      // createToast(toast: TOAST.error,text:LocaleKeys.networkIssue.tr());
      emit(SearchLocationFail());
      rethrow;
    }
  }

}
