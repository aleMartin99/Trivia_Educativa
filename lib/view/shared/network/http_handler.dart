import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHandler {
  final String _baseUrl = '10.0.2.2:3000';

  Future<dynamic> getJson(Uri uri) async {
    http.Response response = await http.get(uri);
    return json.decode(response.body).toString();
  }

  Future<String> fetchAsignaturas() {
    var uri = Uri.http(
      _baseUrl,
      "asignaturas",
    );
    return getJson(uri).then((value) => value.toString());
  }
}
