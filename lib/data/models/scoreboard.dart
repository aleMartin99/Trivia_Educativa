class ScoreBoard {
  late double promedio;
  late String name;
  //TODO add scoreboard id
  //late String id;

  ScoreBoard({
    required this.promedio,
    required this.name,
    //TODO add scoreboard id required this.id
    // this.imagen
  });

  ScoreBoard.reciprocal(double d) {
    1 / d;
  }

  ScoreBoard.fromJson(Map<String, dynamic> json) {
    if (json['promedio'] is int) {
      int x = json['promedio'];

      ScoreBoard.reciprocal(x.toDouble());
      promedio = x.toDouble();
    } else {
      promedio = json['promedio'];
    }

    name = (json['name']);
    //TODO add scoreboard id   id = (json['name']);
  }
}
