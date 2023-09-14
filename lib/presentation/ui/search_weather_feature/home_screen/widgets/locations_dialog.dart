import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:webkeys/presentation/bloc/weather_cubit/weather_cubit.dart';

import '../../../../../shared/di/injection.dart';
import '../../../../../shared/resources/colors_manager.dart';
import '../../../../../shared/resources/responsive_screens_controller.dart';
import '../../../../../shared/resources/routes_manager.dart';


class SavedLocationsDialog extends StatelessWidget {
  const SavedLocationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final locationCubit = BlocProvider.of<WeatherCubit>(context);
    return SizedBox(
      height: ScreenSize.screenHeight *.42,
      width: ScreenSize.screenWidth * 0.95,
      child: ListView.builder(
        itemCount: locationCubit.userSavedLocationsList.length,
        padding: const EdgeInsets.all( 20),
        itemBuilder: (context, index) {

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                    locationCubit.userSavedLocationsList[index].timezone,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color:  Colors.black,
                      fontSize: 18,
                    )),
                const Divider(color: ColorManager.homeColorDark,
                  thickness: 2,
                )
              ],
            );

        },
      ),
    );
  }
}
Future<void> showSavedLocationsDialog() async {



  await showDialog(
    barrierDismissible: true,
    context: sl<NavigatorManager>().navigatorKey.currentContext!,
    builder: (context) {
      return BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: ScreenSize.screenWidth * (1 / 1280.0),
          sigmaY: ScreenSize.screenWidth * (1 / 1280.0),
        ),
        child: const Dialog(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: Colors.white,
          child: SavedLocationsDialog(),
        ),
      );
    },
  );
}