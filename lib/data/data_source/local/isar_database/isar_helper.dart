import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webkeys/data/data_source/local/isar_database/save_data_model.dart';

import '../../../../shared/error/exceptions.dart';


class IasrHelper {
  late Future<Isar> db;

  IasrHelper() {
    db = openDB();
  }

  Future<void> put(String dbKey, dynamic v) async {
    try{
      final iser = await db;
      SaveDataModel ret = SaveDataModel()
        ..value = jsonEncode(v)
        ..key = dbKey;
      iser.writeTxnSync(() => iser.saveDataModels.putByKeySync(ret));
    }
    catch(e){
      debugPrint("Isar Error Exception");
      debugPrint(e.toString());
    }

  }

  Future get(String key) async {
    final iser = await db;
    final f = await _basicErrorHandling(() async {
      try {
        var data =
            jsonDecode(iser.saveDataModels.getByKeySync(key)!.value.toString());
        return data;
      } catch (e) {
        return null;
      }
    });
    return f;
  }

  Future clear(String key) async {
    final isar = await db;
    final f = await _basicErrorHandling(() async {
      try {
        await isar.writeTxn(() async {
          await isar.saveDataModels.deleteByKey(key);
        });
      } catch (e) {
        debugPrint(e.toString());
        return null;
      }
    });
    return f;
  }

  Future resetData() async {
    final isar = await db;
    final f = await _basicErrorHandling(() async {
      try {
        await isar.writeTxn(() async {
          await isar.saveDataModels.clear();
        });
      } catch (e) {
        debugPrint(e.toString());
        return null;
      }
    });
    return f;
  }

  Directory? externalDirectory;
  Future<void> getExternalStorage() async {
    if (Platform.isIOS) {
      externalDirectory = await getApplicationDocumentsDirectory();
    } else {
      externalDirectory = await getExternalStorageDirectory();
    }
  }

  Future<Isar> openDB() async {
    await getExternalStorage();
    if (Isar.instanceNames.isEmpty) {
      await Isar.open(
        [SaveDataModelSchema],
        inspector: true,
        maxSizeMiB: 500,
        directory: externalDirectory!.path,
      );
    }
    return Future.value(Isar.getInstance());
  }
}

extension on IasrHelper {
  Future<T> _basicErrorHandling<T>(Future<T> Function() onSuccess) async {
    try {
      final f = await onSuccess.call();
      return f;
    } catch (e) {
      throw CacheException(e);
    }
  }
}
