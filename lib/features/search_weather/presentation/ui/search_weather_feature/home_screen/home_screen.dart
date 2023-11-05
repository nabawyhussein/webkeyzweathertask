import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webkeys/features/search_weather/presentation/ui/common_widgets/build_text.dart';

import '../../../../../../core/shared/resources/colors_manager.dart';
import '../../../../../../core/shared/resources/constants_manager.dart';
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
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [ColorManager.homeColorLight, ColorManager.homeColorDark],
            // ),
            ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenSize.screenHeight * .015,
              ),
              Image.asset("assets/backGrounds/authScreensBackground.png",
                  // height: ScreenSize.screenHeight * .2,
                  width: ScreenSize.screenWidth,
                  fit: BoxFit.fill),
              BuildTextField(
                textController: searchController,
                keyboardType: TextInputType.text,
                labelTxt: 'Enter Location Name',
              ),
              SizedBox(
                height: ScreenSize.screenHeight * .04,
              ),
              BlocBuilder<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  if (state is SearchLocationLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: ColorManager.homeColorDark,
                    ));
                  }
                  return BuildButtonWithBackGround(
                    btnText: 'Search',
                    onTap: () {
                      if (searchController.text.isNotEmpty) {
                        locationCubit.getWeatherByLocation(
                            locationName: searchController.text);
                      } else {
                        showSimpleToast(msg: "Enter Valid Data");
                      }
                    },
                  );
                },
              ),
              SizedBox(
                height: ScreenSize.screenHeight * .04,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ConstantsManager.borderRadius),
                    border: Border.all(color: Colors.grey)),
                width: ScreenSize.screenWidth * .4,
                height: ScreenSize.screenHeight * .15,
                // padding: EdgeInsets.all(ScreenSize.screenHeight*0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.scale(
                      scale: .7,
                      child: Checkbox(
                          value: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            // side: const BorderSide(width: 1,color: Colors.green)
                          ),
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => const BorderSide(
                              width: 2.0,
                              color: Colors.red,
                              strokeAlign: 5,
                            ),
                          ),
                          fillColor: MaterialStateColor.resolveWith((states) {
                            return Colors.red;
                          }),
                          checkColor: Colors.red,
                          onChanged: (v) {}),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: BuildText(
                        txt: "Unit 57-A",
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: ScreenSize.screenHeight * .04,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: .7,
                    child: Checkbox(
                        value: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          // side: const BorderSide(width: 1,color: Colors.green)
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(
                            width: 2.0,
                            color: Colors.red,
                            strokeAlign: 5,
                          ),
                        ),
                        fillColor: MaterialStateColor.resolveWith((states) {
                          return Colors.red;
                        }),
                        checkColor: Colors.red,
                        onChanged: (v) {}),
                  ),
                  const BuildText(
                    txt: "National ID",
                    fontSize: 18,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: ScreenSize.screenHeight * .04,
              ),
              SizedBox(
                width: ScreenSize.screenWidth * 0.85,
                height: ScreenSize.screenHeight * 0.08,
                child: DottedBorder(
                  color: Colors.grey,
                  strokeWidth: 2,
                  dashPattern: const [10, 10, 10, 10],
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.screenWidth * .065,
                      vertical: ScreenSize.screenHeight * 0.02),
                  // borderType: BorderType.Rect,
                  // borderPadding: EdgeInsets.symmetric(horizontal: 5),
                  borderType: BorderType.RRect,
                  radius: Radius.circular(ConstantsManager.borderRadius),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BuildText(
                        txt: "Upload national ID-Front",
                        fontSize: 18,
                        textAlign: TextAlign.center,
                      ),
                      SvgPicture.asset(
                        'assets/icons/uploadIdIcon.svg',
                        // width: 50,
                        // height: 50,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenSize.screenHeight * .04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
