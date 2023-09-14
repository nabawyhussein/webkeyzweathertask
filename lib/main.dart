import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/shared/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}
