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

  // DASHBOARD DO ALUNO
  static Future<Map<String, dynamic>> buscarDashboard(
    int alunoId,
  ) async {
    var response = await http.get(
      Uri.parse(
        '$baseUrl/dashboard.php?aluno_id=$alunoId',
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      'Erro ao carregar dashboard. Status: ${response.statusCode}',
    );
  }

  // BUSCAR QUESTÃO
static Future<Map<String, dynamic>> buscarQuestao(
  int nivel,
) async {

  var response = await http.get(
    Uri.parse(
      '$baseUrl/buscar_questao.php?nivel=$nivel',
    ),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  throw Exception(
    'Erro ao carregar questão. Status: ${response.statusCode}',
  );
}

static Future<void> adicionarPontos(
  int alunoId,
  int nivelId,
  int pontos,
) async {

  await http.post(
    Uri.parse(
      '$baseUrl/atualizar_pontuacao.php',
    ),
    body: {
      "aluno_id": alunoId.toString(),
      "nivel_id": nivelId.toString(),
      "pontos": pontos.toString(),
    },
  );
  
}

static Future<void> finalizarNivel(
  int alunoId,
  int nivelId,
  String tipo,
) async {
  await http.post(
    Uri.parse('$baseUrl/finalizar_nivel.php'),
    body: {
      "aluno_id": alunoId.toString(),
      "nivel_id": nivelId.toString(),
      "tipo": tipo,
    },
  );
}

static Future<Map<String, dynamic>> buscarAssociacao(
  int nivel,
) async {
  final response = await http.get(
    Uri.parse('$baseUrl/buscar_associacao.php?nivel=$nivel'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  throw Exception(
    'Erro ao carregar associação. Status: ${response.statusCode}',
  );
}
}