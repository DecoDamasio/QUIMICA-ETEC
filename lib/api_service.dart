import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String url =
      "http://localhost/api_etec/login.php";

  static Future<Map<String, dynamic>> login(
    String tipo,
    String email,
    String senha,
  ) async {

    var response = await http.post(
      Uri.parse(url),
      body: {
        "tipo": tipo,
        "email": email,
        "senha": senha,
      },
    );

    return jsonDecode(response.body);
  }
}