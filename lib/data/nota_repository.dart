import 'package:trivia_educativa/data/adapters/nota_local_adapter.dart';
import 'package:trivia_educativa/data/models/nota_local.dart';

import '../main.dart';
import 'datasources/nota_local_data_source.dart';

class NotaRepository {
  NotaRepository(Object object);
  var local = sl<NotaLocalDataSource>();
  // final NotaLocalDataSource local;

  @override
  Future<List<NotaLocal>> getNotas() async {
    final adapter = await local.getNotas();
    final notas = adapter.map((e) => e.toDomain()).toList();
    return notas;
  }

  @override
  Future<void> addNota(NotaLocal nota) async {
    await local.addNota(NotaLocalAdapt.fromDomain(nota));
  }

  @override
  Future<void> deleteAllNotas() async {
    await local.deleteAll();
  }

  @override
  Future<void> deleteNota(int id) async {
    await local.deleteNota(id);
  }
}
