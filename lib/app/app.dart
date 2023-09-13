
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/bloc/weather_cubit/weather_cubit.dart';
import '../shared/di/injection.dart';
import '../shared/resources/routes_manager.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(create: (context) => WeatherCubit()),
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
