
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:webkeys/features/search_weather/data/models/weather_details_model.dart';
import 'package:mockito/mockito.dart';
import 'package:webkeys/features/search_weather/presentation/bloc/weather_cubit/weather_cubit.dart';

class MockWeather extends WeatherCubit with Mock{}

class MockWeatherModel extends WeatherDetailsModel with Mock{
  MockWeatherModel({required super.lat, required super.lon, required super.timezone, required super.timezoneOffset, required super.current, required super.daily});
}
void main()
{
  group('test Search Weather', () { 
    test('search Valid Name', () async {
      MockWeather mockWeather = MockWeather ();
      Location? mockLocation = await mockWeather.getLocationByName(locationName: 'egypt');
      expect(mockLocation?.latitude, 26.820553);
      // WeatherDetailsModel? mockWeatherModel = await mockWeather.getWeatherDetails(locationName: 'egypt');

    });
    
  });

}