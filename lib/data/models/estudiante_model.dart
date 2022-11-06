class Estudiante {
  String? id;
  String? name;
  String? ci;
  //TODO chech with carlos annoCurso tipo de dato(carlos string pero yo digo q int (revisar caso de universidad o casos x default en string ))
  int? annoCurso;
  //String? fechaNacimiento;

  Estudiante({
    this.id,
    this.name,
    this.ci,
    this.annoCurso,
    // this.fechaNacimiento,
  });

  Estudiante.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['nombre'];
    ci = json['CI'];
    annoCurso = json['ano'];
    //fechaNacimiento = json['fechaNacimiento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['nombre'] = name;
    data['CI'] = ci;
    data['ano'] = annoCurso;
    //data['fechaNacimiento'] = fechaNacimiento;

    return data;
  }
}
