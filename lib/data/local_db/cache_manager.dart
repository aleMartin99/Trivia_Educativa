// ignore_for_file: public_member_api_docs

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../adapters/nota_local_adapter.dart';
import 'const.dart';

class CacheManager {
  CacheManager(Object object);
  late Box _notasBox;

  Future<CacheManager> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive
      ..init(directory.path)
      ..registerAdapter(NotaLocalAdaptAdapter());

    _notasBox = await Hive.openBox<dynamic>(CacheBoxes.notasBox);

    return this;
  }

  Box _getBox(String boxName) {
    switch (boxName) {
      case CacheBoxes.notasBox:
        return _notasBox;
      default:
        return _notasBox;
    }
  }

  Future<List<T>> getAll<T>(String boxName) async {
    final box = _getBox(boxName);
    final boxList = <T>[];
    final length = box.length;

    for (var i = 0; i < length; i++) {
      boxList.add(box.getAt(i) as T);
    }
    return boxList;
  }

  Future<int> add<T>(T item, String boxName) async {
    final box = _getBox(boxName);
    final response = await box.add(item);
    return response;
  }

  Future<void> delete<T>(int key, String boxName) async {
    final box = _getBox(boxName);
    await box.delete(key);
  }

  Future<void> deleteAll<T>(String boxName) async {
    final box = _getBox(boxName);
    await box.clear();
  }

  Future<void> update<T>(
    T item,
    int id,
    String boxName,
  ) async {
    final box = _getBox(boxName);
    await box.put(id, item);
  }
}
