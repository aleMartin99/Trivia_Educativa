class Estudiante {
  late String id;
  late String name;
  late String ci;
  late int annoCurso;

  Estudiante({
    required this.id,
    required this.name,
    required this.ci,
    required this.annoCurso,
  });

  Estudiante.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    ci = json['CI'];
    annoCurso = json['annoCurso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['CI'] = ci;
    data['annoCurso'] = annoCurso;
    return data;
  }
}
