// ignore_for_file: public_member_api_docs

import '../../main.dart';
import '../adapters/nota_local_adapter.dart';
import '../local_db/cache_manager.dart';
import '../local_db/const.dart';

class NotaLocalDataSource {
  NotaLocalDataSource(Object object);
  var cacheManager = sl<CacheManager>();

  Future<List<NotaLocalAdapt>> getNotas() {
    return cacheManager.getAll(CacheBoxes.notasBox);
  }

  Future<void> addNota(NotaLocalAdapt nota) async {
    await cacheManager.add<NotaLocalAdapt>(nota, CacheBoxes.notasBox);
  }

  Future<void> deleteNota(int id) async {
    await cacheManager.delete<dynamic>(id, CacheBoxes.notasBox);
  }

  Future<void> deleteAll() async {
    await cacheManager.deleteAll(CacheBoxes.notasBox);
  }
}
