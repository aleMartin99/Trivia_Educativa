class Estudiante {
  String? id;
  String? nombre;
  String? cI;
  int? ano;
  String? fechaNacimiento;

  Estudiante({
    this.id,
    this.nombre,
    this.cI,
    this.ano,
    this.fechaNacimiento,
  });

  Estudiante.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nombre = json['nombre'];
    cI = json['CI'];
    ano = json['ano'];
    fechaNacimiento = json['fechaNacimiento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['nombre'] = nombre;
    data['CI'] = cI;
    data['ano'] = ano;
    data['fechaNacimiento'] = fechaNacimiento;

    return data;
  }
}
