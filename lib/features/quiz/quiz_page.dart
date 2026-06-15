import 'package:flutter/material.dart';
import '../../api_service.dart';
import '../../widgets/components_quiz/quiz_header.dart';
import '../../widgets/components_quiz/quiz_question_card.dart';
import '../../widgets/components_quiz/quiz_options.dart';
import '../../widgets/components_quiz/quiz_action_buttons.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String? _selectedAlternative;

  int _hintsAvailable = 3;
  int _eliminationsAvailable = 2;

  late Future<Map<String, dynamic>> questaoFuture;

  @override
  void initState() {
    super.initState();

    questaoFuture = ApiService.buscarQuestao(1);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth =
        screenWidth > 800 ? 800.0 : screenWidth * 0.95;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quiz - Nível 1',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Questão',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: FutureBuilder<Map<String, dynamic>>(
        future: questaoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro: ${snapshot.error}",
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!["success"] != true) {
            return const Center(
              child: Text(
                "Nenhuma questão encontrada",
              ),
            );
          }

          final questao = snapshot.data!["questao"];

          final List<Map<String, String>> alternatives = [
            {
              "id": "A",
              "text": questao["alt_a"].toString(),
            },
            {
              "id": "B",
              "text": questao["alt_b"].toString(),
            },
            {
              "id": "C",
              "text": questao["alt_c"].toString(),
            },
            {
              "id": "D",
              "text": questao["alt_d"].toString(),
            },
          ];

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  width: containerWidth,
                  child: Column(
                    children: [
                      const QuizHeader(
                        points: 0,
                        timeLeft: "00:00",
                      ),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(
                              0xFFE0E6ED,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            QuizQuestionCard(
                              assetPath:
                                  "assets/images/${questao["imagem"]}",
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              'Pergunta',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              questao["pergunta"]
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold,
                                color:
                                    Color(0xFF1E293B),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'Selecione a alternativa correta:',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Colors.grey[600],
                              ),
                            ),

                            const SizedBox(height: 20),

                            QuizOptions(
                              alternatives:
                                  alternatives,
                              selectedId:
                                  _selectedAlternative,
                              onSelected: (id) {
                                setState(() {
                                  _selectedAlternative =
                                      id;
                                });
                              },
                            ),

                            const SizedBox(height: 24),

                            QuizActionButtons(
                              hints:
                                  _hintsAvailable,
                              eliminations:
                                  _eliminationsAvailable,
                              onHintPressed:
                                  _hintsAvailable > 0
                                      ? () {
                                          setState(() {
                                            _hintsAvailable--;
                                          });

                                          ScaffoldMessenger.of(
                                                  context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text(
                                                questao["dica"]
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                              onEliminatePressed:
                                  _eliminationsAvailable >
                                          0
                                      ? () {
                                          setState(() {
                                            _eliminationsAvailable--;
                                          });
                                        }
                                      : null,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed:
                              _selectedAlternative ==
                                      null
                                  ? null
                                  : () {
                                      bool acertou =
                                          _selectedAlternative ==
                                              questao[
                                                  "resposta_correta"];

                                      showDialog(
                                        context:
                                            context,
                                        builder:
                                            (_) =>
                                                AlertDialog(
                                          title: Text(
                                            acertou
                                                ? "Correto!"
                                                : "Incorreto",
                                          ),
                                          content:
                                              Text(
                                            acertou
                                                ? "Você acertou a questão."
                                                : "Resposta correta: ${questao["resposta_correta"]}",
                                          ),
                                        ),
                                      );
                                    },
                          child: const Text(
                            "Confirmar Resposta",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}