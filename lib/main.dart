import 'package:flutter/material.dart';
import 'package:webkeys/shared/di/injection.dart' as di;

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}


