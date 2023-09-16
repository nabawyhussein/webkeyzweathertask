import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/shared/di/injection.dart';
import '../core/shared/resources/routes_manager.dart';
import '../features/search_weather/presentation/bloc/weather_cubit/weather_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(create: (context) => WeatherCubit(sl())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: sl<NavigatorManager>().navigatorKey,
          title: 'WebKeyZ',
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashRoute,
        ));
  }
}
