import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../core/shared/di/injection.dart';
import '../../../../../core/shared/resources/routes_manager.dart';
import '../common_widgets/build_logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late AnimationController _animationController;
  late Animation<double> _animation;

  _startDelay() async {
    _timer = Timer(const Duration(seconds: 1), _goNextScreen);
  }

  _goNextScreen() {
    sl<NavigatorManager>().pushReplacementNamed(Routes.homeScreenRoute);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInQuad,
    );
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _startDelay();
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer!.cancel();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: AnimatedBuilder(
          animation: _animation,
          child: const BuildLogoWidget(),
          builder: (_, child) {
            return Opacity(
              opacity: _animation.value,
              child: Transform.translate(
                offset: Offset(0, (1 - _animation.value) * -300),
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }
}
