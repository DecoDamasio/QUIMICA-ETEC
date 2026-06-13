import 'package:flutter/material.dart';
import '../../theme/app_text_styles.dart'; // Mantido o padrão do seu projeto
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

  // Lista simulada de alternativas com base no seu print
  final List<Map<String, String>> _alternatives = [
    {"id": "A", "text": "Béquer"},
    {"id": "B", "text": "Erlenmeyer"},
    {"id": "C", "text": "Proveta"},
    {"id": "D", "text": "Balão Volumétrico"},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Define a largura máxima adaptável (Responsivo Web vs Mobile)
    final double containerWidth = screenWidth > 800 ? 800.0 : screenWidth * 0.95;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA), // Tom de fundo levemente azulado/cinza do print
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
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Questão 3 de 10',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: 0.3, // 3 de 10 questões
            backgroundColor: Color(0xFFE0E6ED),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00A3E0)),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              width: containerWidth,
              child: Column(
                children: [
                  // Indicadores de Pontos e Tempo
                  const QuizHeader(points: 850, timeLeft: "02:45"),
                  const SizedBox(height: 20),

                  // Container Principal Branco (Borda tracejada externa simulada por Card)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE0E6ED)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Central do Equipamento (Tubo de ensaio/Vidraria)
                        const QuizQuestionCard(assetPath: 'assets/images/tubo_ensaio.png'),
                        const SizedBox(height: 20),

                        const Text(
                          'Pergunta',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Identifique o equipamento de laboratório apresentado na imagem:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Selecione a alternativa correta:',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 20),

                        // Grid/Lista de Alternativas Responsiva
                        QuizOptions(
                          alternatives: _alternatives,
                          selectedId: _selectedAlternative,
                          onSelected: (id) => setState(() => _selectedAlternative = id),
                        ),
                        const SizedBox(height: 24),

                        // Botões de Ajuda (Dica e Eliminar)
                        QuizActionButtons(
                          hints: _hintsAvailable,
                          eliminations: _eliminationsAvailable,
                          onHintPressed: _hintsAvailable > 0
                              ? () => setState(() => _hintsAvailable--)
                              : null,
                          onEliminatePressed: _eliminationsAvailable > 0
                              ? () => setState(() => _eliminationsAvailable--)
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botão Confirmar Resposta Fixo/Inferior
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _selectedAlternative != null ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC6D2E1), // Cor desabilitada/padrão do print
                        disabledBackgroundColor: const Color(0xFFE2E8F0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Confirmar Resposta',
                        style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}