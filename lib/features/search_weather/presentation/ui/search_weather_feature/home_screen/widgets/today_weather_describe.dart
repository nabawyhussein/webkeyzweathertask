import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/shared/resources/responsive_screens_controller.dart';
import '../../../../bloc/weather_cubit/weather_cubit.dart';
import '../../../common_widgets/build_text.dart';

class TodayWeatherDescribe extends StatelessWidget {
  const TodayWeatherDescribe({super.key});

  @override
  Widget build(BuildContext context) {
    final locationCubit = BlocProvider.of<WeatherCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: ScreenSize.screenHeight * .02,
        ),
        BuildText(
          txt: "${locationCubit.weatherDetailsModel!.timezone} Today",
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        SizedBox(
          height: ScreenSize.screenHeight * .01,
        ),
        BuildText(
          txt: "Temperature ${locationCubit.weatherDetailsModel!.current.temp}",
        ),
        BuildText(
          txt:
              "Describe ${locationCubit.weatherDetailsModel!.current.weather.first.description}",
        ),
        BuildText(
          txt:
              "Humidity percentage ${locationCubit.weatherDetailsModel!.current.humidity}",
        ),
        BuildText(
          txt:
              "Wind Speed ${locationCubit.weatherDetailsModel!.current.windSpeed}",
        ),
      ],
    );
  }
}
