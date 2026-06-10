import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = "http://localhost/api_etec";

  // LOGIN
  static Future<Map<String, dynamic>> login(
    String tipo,
    String email,
    String senha,
  ) async {

    var response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {
        "tipo": tipo,
        "email": email,
        "senha": senha,
      },
    );

    return jsonDecode(response.body);
  }

  // RANKING
  static Future<List<dynamic>> buscarRanking() async {

    var response = await http.get(
      Uri.parse('$baseUrl/ranking.php'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      'Erro ao carregar ranking. Status: ${response.statusCode}',
    );
  }
}