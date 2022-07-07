class Profesor {
  late String id;
  late String nombre;
  late String cI;

  Profesor({
    required this.id,
    required this.nombre,
    required this.cI,
  });

  Profesor.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nombre = json['nombre'];
    cI = json['CI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = id;

    data['nombre'] = nombre;
    data['CI'] = cI;
    return data;
  }
}

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$oid'] = oid;
    return data;
  }
}
