import 'package:get_it/get_it.dart';

import '../../../features/search_weather/data/data_source/local/isar_database/isar_helper.dart';
import '../../../features/search_weather/data/data_source/remote/weather_repo.dart';
import '../../../features/search_weather/data/repo/repo_imp.dart';
import '../../../features/search_weather/domain/repo/repo_abstract.dart';
import '../../../features/search_weather/domain/use_cases/search_weather_use_case.dart';
import '../../../features/search_weather/presentation/bloc/weather_cubit/weather_cubit.dart';
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
  sl.registerLazySingleton(
    () => WeatherCubit(SearchWeatherUseCase(sl())),
  );
  sl.registerLazySingleton(
    () => SearchWeatherUseCase(sl()),
  );

  sl.registerLazySingleton<RepoBase>(() => RepoImp(sl()));
  sl.registerLazySingleton<BaseSearchWeatherRemote>(
      () => SearchWeatherRemote());
}
