import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:webkeys/features/search_weather/presentation/ui/search_weather_feature/home_screen/widgets/today_weather_describe.dart';

import '../../../../../../../core/shared/resources/assets_manger.dart';
import '../../../../../../../core/shared/resources/responsive_screens_controller.dart';
import '../../../../bloc/weather_cubit/weather_cubit.dart';
import '../../../common_widgets/build_button.dart';
import 'locations_dialog.dart';
import 'next_days_weathed_describe.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final locationCubit = BlocProvider.of<WeatherCubit>(context);
    return BlocBuilder<WeatherCubit, WeatherState>(
      buildWhen: (previous, current) =>
          previous != current &&
          (current is WeatherDataFoundSuccess ||
              current is SaveLocationSuccess ||
              current is SearchLocationLoading ||
              current is WeatherDataFoundFail),
      builder: (context, state) {
        if (state is WeatherDataFoundSuccess || state is SaveLocationSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TodayWeatherDescribe(),
              SizedBox(
                height: ScreenSize.screenHeight * .01,
              ),
              NextDaysWeatherDescribe(),
              Row(
                mainAxisAlignment:
                    locationCubit.userSavedLocationsList.isNotEmpty
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (locationCubit.userSavedLocationsList.isNotEmpty)
                    BuildButtonWithBackGround(
                      btnText: "Saved Weathers",
                      btnColor: Colors.black,
                      width: ScreenSize.screenWidth * .41,
                      height: ScreenSize.screenHeight * .05,
                      onTap: () {
                        showSavedLocationsDialog();
                      },
                    ),
                  BuildButtonWithBackGround(
                    btnText: "Save",
                    btnColor: Colors.black,
                    width: ScreenSize.screenWidth * .41,
                    height: ScreenSize.screenHeight * .05,
                    onTap: () {
                      locationCubit.setUserSavedLocations(
                          locationName: searchController.text);
                    },
                  ),
                ],
              ),
            ],
          );
        }

        return Lottie.asset(AppLottie.weatherLoadingLottie,
            height: ScreenSize.screenHeight * .43,
            width: ScreenSize.screenWidth,
            fit: BoxFit.cover);
      },
    );
  }
}
