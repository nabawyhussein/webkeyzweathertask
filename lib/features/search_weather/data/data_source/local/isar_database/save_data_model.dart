import 'package:isar/isar.dart';

part 'save_data_model.g.dart';

@collection
class SaveDataModel {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? value;
  @Index(unique: true, replace: true)
  String? key;
}
