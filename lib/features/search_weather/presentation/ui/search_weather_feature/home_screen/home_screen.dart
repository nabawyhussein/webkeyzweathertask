import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:webkeys/features/search_weather/presentation/ui/search_weather_feature/home_screen/widgets/locations_dialog.dart';
import 'package:webkeys/features/search_weather/presentation/ui/search_weather_feature/home_screen/widgets/next_days_weathed_describe.dart';
import 'package:webkeys/features/search_weather/presentation/ui/search_weather_feature/home_screen/widgets/today_weather_describe.dart';
import '../../../../../../core/shared/resources/assets_manger.dart';
import '../../../../../../core/shared/resources/colors_manager.dart';
import '../../../../../../core/shared/resources/responsive_screens_controller.dart';
import '../../../bloc/weather_cubit/weather_cubit.dart';
import '../../common_widgets/build_button.dart';
import '../../common_widgets/build_text_field.dart';
import '../../common_widgets/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController searchController;
  String selectedKey = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final locationCubit = BlocProvider.of<WeatherCubit>(context);
    // locationCubit.getMyCurrentLocation();
    return Scaffold(
      body: Container(
        width: ScreenSize.screenWidth,
        height: ScreenSize.screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorManager.homeColorLight, ColorManager.homeColorDark],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: ScreenSize.screenHeight*.05,),
              Lottie.asset(AppLottie.weatherLottie,
              height: ScreenSize.screenHeight*.23,
                width: ScreenSize.screenWidth*.6,
                fit: BoxFit.fill
              ),

              BuildTextField(
                textController: searchController,
                keyboardType: TextInputType.text,
                labelTxt: 'Enter Location Name',
              ),

              BlocBuilder<WeatherCubit, WeatherState>(
                // buildWhen: (previous, current) => previous != current
                //     && (current is SearchLocationRemoteLoading ||
                //         current is SearchLocationRemoteSuccess ||
                //         current is WeatherDataFoundSuccess ||
                //         current is WeatherDataFoundFail ||
                //         current is SearchLocationRemoteFail  ),
                builder: (context, state) {
                  if (state is SearchLocationRemoteLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.homeColorDark,
                        ));
                  }

                  return BuildButton(btnText: 'Search',
                    onTap: () {
                    if(searchController.text.isNotEmpty) {
                      locationCubit.searchLocationWeather(locationName: searchController.text);
                    }
                    else{
                      showSimpleToast( msg: "Enter Valid Data");
                    }
                    },
                  );
                },
              ),
              BlocBuilder<WeatherCubit, WeatherState>(
                buildWhen: (previous, current) => previous != current
                    && (
                        current is WeatherDataFoundSuccess ||
                        current is SaveLocationSuccess ||
                        current is SearchLocationRemoteLoading ||
                        current is WeatherDataFoundFail  ),
                builder: (context, state) {
                  if (state is WeatherDataFoundSuccess || state is SaveLocationSuccess) {
                    return   Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                         TodayWeatherDescribe(),
                        SizedBox(height: ScreenSize.screenHeight*.01,),
                         NextDaysWeatherDescribe(),
                        Row(
                          mainAxisAlignment:
                          locationCubit.userSavedLocationsList.isNotEmpty
                              ?
                          MainAxisAlignment.spaceEvenly
                              :
                          MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (locationCubit.userSavedLocationsList.isNotEmpty)
                              BuildButton(btnText: "Saved Weathers",
                                btnColor: Colors.black,
                                width: ScreenSize.screenWidth*.41,
                                height: ScreenSize.screenHeight*.05,
                                onTap: (){
                                  showSavedLocationsDialog();
                                },
                              ),
                            BuildButton(btnText: "Save",
                              btnColor: Colors.black,
                              width: ScreenSize.screenWidth*.41,
                              height: ScreenSize.screenHeight*.05,
                              onTap: (){
                                locationCubit.setUserSavedLocations(locationName: searchController.text);
                              },
                            ),

                          ],
                        ),
                      ],
                    );
                  }

                  return  Lottie.asset(
                      AppLottie.weatherLoadingLottie,
                      height: ScreenSize.screenHeight*.43,
                      width: ScreenSize.screenWidth,
                      fit: BoxFit.cover
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
