class ScoreBoard {
  late int promedio;
  late String name;

//TODO make token global with shared preferences
  ScoreBoard({
    required this.promedio,
    required this.name,
    // this.imagen
  });

  ScoreBoard.fromJson(Map<String, dynamic> json) {
    promedio = json['promedio'];
    name = (json['name']);
  }
}
