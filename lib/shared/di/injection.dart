import 'package:get_it/get_it.dart';

import '../../data/data_source/local/isar_database/isar_helper.dart';
import '../resources/routes_manager.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia

  sl.registerLazySingleton<IasrHelper>(
    () => IasrHelper(),
  );

  // navigator
  sl.registerLazySingleton(
    () => NavigatorManager(),
  );
}
