import '../../../../../../core/shared/di/injection.dart';
import '../../../models/weather_details_model.dart';
import 'isar_helper.dart';

class LocalDBController {
  static Future<void> setSavedLocationList(List<WeatherDetailsModel> v) async =>
      await sl<IasrHelper>()
          .put('SavedLocationList', v.map((e) => e.toJson()).toList());

  static Future<List<WeatherDetailsModel>> get getSavedLocationList async {
    final cashedList = await sl<IasrHelper>().get('SavedLocationList');

    if (cashedList != null) {
      return cashedList
          .map<WeatherDetailsModel>((e) => WeatherDetailsModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}
