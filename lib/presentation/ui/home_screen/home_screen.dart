import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webkeys/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:webkeys/presentation/ui/common_widgets/build_button.dart';
import 'package:webkeys/shared/resources/responsive_screens_controller.dart';

import '../../../shared/resources/colors_manager.dart';
import '../common_widgets/build_text_field.dart';

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
        child: Padding(
          padding: EdgeInsets.all(ScreenSize.screenWidth * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildTextField(
                textController: searchController,
                keyboardType: TextInputType.text,
                labelTxt: 'Enter Location Name',
              ),

              BlocBuilder<WeatherCubit, WeatherState>(
                buildWhen: (previous, current) => previous != current
                    && (current is SearchLocationLoading ||
                        current is SearchLocationSuccess ||
                        current is SearchLocationFail  ),
                builder: (context, state) {
                  if (state is SearchLocationLoading) {
                    return const Center(
                      // child: CircularProgressIndicator());
                        child: CircularProgressIndicator(
                          color: ColorManager.primaryColor,
                        ));
                  }

                  return BuildButton(btnText: 'Search',
                    onTap: () {
                    if(searchController.text.isNotEmpty) {
                      locationCubit.searchLocationWeather(locationName: searchController.text);
                    }
                    },
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
