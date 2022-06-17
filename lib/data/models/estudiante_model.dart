class Estudiante {
  String? id;
  String? nombre;
  String? cI;
  int? ano;
  String? fechaNacimiento;
  int? iV;

  Estudiante(
      {this.id, this.nombre, this.cI, this.ano, this.fechaNacimiento, this.iV});

  Estudiante.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nombre = json['nombre'];
    cI = json['CI'];
    ano = json['ano'];
    fechaNacimiento = json['fechaNacimiento'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['nombre'] = this.nombre;
    data['CI'] = this.cI;
    data['ano'] = this.ano;
    data['fechaNacimiento'] = this.fechaNacimiento;
    data['__v'] = this.iV;
    return data;
  }
}
