import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../presentation/ui/home_screen/home_screen.dart';
import '../../presentation/ui/splash/splash_screen.dart';


class Routes {
  static const String splashRoute = "/";
  static const String homeScreenRoute = "/homeScreenRoute";
}

class RouteGenerator {
  static const initialRouteName = Routes.splashRoute;
  static final _routeNameNotifier = ValueNotifier<String>(initialRouteName);

  /// Reactive version for [currentRouteName].
  static ValueNotifier<String> get routeNameNotifier => _routeNameNotifier;

  /// The current route id. If the current route
  /// is reached in a way other than [Navigator.toNamed],
  /// this id is stale.
  static String get routeName => _routeNameNotifier.value;

  static void onRouteChanged(String? routeName) {
    _routeNameNotifier.value = routeName ?? 'Error';

    log(
      _routeNameNotifier.value,
      name: 'Route',
    );
  }

  /// Callback for MaterialApp's onGenerateRoute.
  static Route<dynamic> getRoute(RouteSettings settings) {
    // Match.
    switch (settings.name) {

      case Routes.splashRoute:
        return AppPageRoute(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );
        case Routes.homeScreenRoute:
        return AppPageRoute(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );

      default:
        return unDefinedRoute(settings);
    }
  }

  static Route<dynamic> unDefinedRoute(RouteSettings settings) {
    return AppPageRoute(
      settings: settings,
      builder: (_) => const Scaffold(
        body: Center(child: Text('No Route Found')),
      ),
    );
  }
}

class NavigatorManager {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> pushReplacementNamed<T extends Object?>(String routeName) {
    RouteGenerator.onRouteChanged(routeName);
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future<T?> pushNamed<T extends Object?>(String routeName) {
    RouteGenerator.onRouteChanged(routeName);
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  void pop<T extends Object?>([T? result]) {
    var predicate = false;
    return navigatorKey.currentState!.popUntil((route) {
      RouteGenerator.onRouteChanged(route.settings.name);
      final value = predicate;
      predicate = true;
      return value;
    });
  }

  /// If no drawer is open, it will pop the current route.
  void closeDrawer<T extends Object?>([T? result]) {
    return navigatorKey.currentState!.pop<T>(result);
  }

  Future<dynamic> navigateAndFinish(String routeName) {
    RouteGenerator.onRouteChanged(routeName);
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }
}

class AppPageRoute extends CupertinoPageRoute {
  AppPageRoute({
    RouteSettings? settings,
    required Widget Function(BuildContext) builder,
  }) : super(
    settings: settings,
    builder: (context) {
      return builder(context);
    },
  );
}
