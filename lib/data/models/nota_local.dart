class NotaLocal {
  NotaLocal({
    required this.idAsignatura,
    required this.idEstudiante,
    required this.idNivel,
    // required this.idNotaProv,
    required this.idTema,
    required this.nota,
  });
  // final String? idNotaProv;
  final String? idAsignatura;
  final String? idTema;
  final String? idNivel;
  final String? idEstudiante;
  final int? nota;
}
