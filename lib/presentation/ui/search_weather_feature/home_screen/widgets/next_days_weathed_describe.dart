import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webkeys/shared/resources/extensions.dart';
import 'package:webkeys/presentation/bloc/weather_cubit/weather_cubit.dart';
import '../../../../../shared/resources/colors_manager.dart';
import '../../../../../shared/resources/responsive_screens_controller.dart';
import '../../../common_widgets/build_text.dart';

class NextDaysWeatherDescribe extends StatelessWidget {
  const NextDaysWeatherDescribe({super.key});

  @override
  Widget build(BuildContext context) {
    final locationCubit = BlocProvider.of<WeatherCubit>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenSize.screenWidth*.05),

        border: Border.all(color: ColorManager.borderColor,width: 2),

      ),
      padding: EdgeInsets.all(ScreenSize.screenWidth*0.02),
      margin: EdgeInsets.all(ScreenSize.screenWidth*0.02),
      child: Column(
        children: [
          const BuildText(txt: "Next 5 Days",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          SizedBox(

            height: ScreenSize.screenHeight*.3,

            child: ListView.separated(
              itemCount: 5,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    BuildText(txt: DateTime.now().add(Duration(days: index+1)).yMd,
                    ),
                    BuildText(txt: "Temperature : ${locationCubit.weatherDetailsModel!.daily[index].temp.day}",
                    ),
                    BuildText(txt: "High : ${locationCubit.weatherDetailsModel!.daily[index].temp.max}",
                    ),
                    BuildText(txt: "Low : ${locationCubit.weatherDetailsModel!.daily[index].temp.min}",
                    ),
                    BuildText(txt: "Describe : ${locationCubit.weatherDetailsModel!.daily[index].weather.first.description}",
                    ),
                  ],
                );

              },

              separatorBuilder: (context, index) {

                return const Divider(color: Colors.white,);

              },

            ),
          ),
        ],
      ),
    );
  }
}
