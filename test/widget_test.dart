import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webkeys/app/app.dart';
import 'package:webkeys/core/shared/di/injection.dart';
import 'package:webkeys/core/shared/resources/routes_manager.dart';
import 'package:webkeys/features/search_weather/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:webkeys/features/search_weather/presentation/ui/common_widgets/build_text_field.dart';
import 'package:webkeys/features/search_weather/presentation/ui/search_weather_feature/home_screen/home_screen.dart';
import 'package:webkeys/features/search_weather/presentation/ui/search_weather_feature/home_screen/widgets/search_results.dart';

void main() {

  testWidgets('Widget presence test', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await init();
    await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(create: (context) => WeatherCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: sl<NavigatorManager>().navigatorKey,
          title: 'WebKeyZ',
          home: const HomeScreen(),
        )));
    // Build your widget tree


    final myWidget = find.byType(BuildTextField);
    final myWidget1 = find.byType(SearchResults);

    expect(myWidget, findsOneWidget);
    expect(myWidget1, findsOneWidget);
    });
}