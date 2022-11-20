// ignore_for_file: public_member_api_docs

import 'package:hive/hive.dart';

import '../models/nota_local.dart';

part 'nota_local_adapter.g.dart';

@HiveType(typeId: 1)
class NotaLocalAdapt extends HiveObject {
  NotaLocalAdapt({
    //required this.idNotaProv
    required this.nota,
    required this.idNotaProv,
    required this.idAsignatura,
    required this.idTema,
    required this.idNivel,
    required this.idEstudiante,
  });
  factory NotaLocalAdapt.fromDomain(NotaLocal response) {
    return NotaLocalAdapt(
      idAsignatura: response.idAsignatura,
      idEstudiante: response.idEstudiante,
      idNivel: response.idNivel,
      idNotaProv: response.idNotaProv,
      idTema: response.idTema,
      nota: response.nota,
    );
  }

  @HiveField(0)
  final String? idNotaProv;

  @HiveField(1)
  final String? idAsignatura;

  @HiveField(2)
  final String? idTema;

  @HiveField(3)
  final String? idNivel;

  @HiveField(4)
  final String? idEstudiante;

  @HiveField(5)
  final int? nota;

  NotaLocal toDomain() {
    return NotaLocal(
      idNotaProv: idNotaProv,
      idTema: idTema,
      nota: nota,
      idAsignatura: idAsignatura,
      idEstudiante: idEstudiante,
      idNivel: idNivel,
    );
  }
}
