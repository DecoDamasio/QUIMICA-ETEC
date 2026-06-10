import 'package:flutter/material.dart';
import 'package:lab_game/widgets/components_quiz/action_button.dart';
import 'package:lab_game/widgets/components_quiz/alternativa_card.dart';
import 'package:lab_game/widgets/components_quiz/quiz_header.dart';
import 'package:lab_game/widgets/universal_back_button.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String? selectedAlternative;

  final List<Map<String, String>> alternatives = [
    {'label': 'A', 'text': 'Béquer'},
    {'label': 'B', 'text': 'Erlenmeyer'},
    {'label': 'C', 'text': 'Proveta'},
    {'label': 'D', 'text': 'Balão Volumétrico'},
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isWeb = mediaQuery.size.width > 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isWeb ? mediaQuery.size.width * 0.15 : 16.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const UniversalBackButton(
                    iconMode: true,
                    iconColor: Colors.black87,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    padding: EdgeInsets.all(12),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quiz - Nível 1',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      Text(
                        'Questão 3 de 10',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const LinearProgressIndicator(
                  value: 0.3,
                  backgroundColor: Color(0xFFE2E8F0),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0EA5E9)),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 24),

              const QuizHeader(points: 850, time: '02:45'),
              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: isWeb ? 300 : 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          style: BorderStyle.solid,
                        ),
                        color: const Color(0xFFFAFAFA),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.science,
                              color: Colors.green.shade400,
                              size: 48,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Imagem da Vidraria',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF475569),
                              ),
                            ),
                            const Text(
                              'Equipamento de Laboratório',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Texto da Pergunta
                    const Text(
                      'Identifique o equipamento de laboratório apresentado na imagem:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Selecione a alternativa correta:',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 24),

                    isWeb
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 4,
                                ),
                            itemCount: alternatives.length,
                            itemBuilder: (context, index) =>
                                _buildAlternative(index),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: alternatives.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) =>
                                _buildAlternative(index),
                          ),
                    const SizedBox(height: 32),
                    const Divider(color: Color(0xFFE2E8F0)),
                    const SizedBox(height: 16),

                    // Botões de Ações (Dica / Eliminar)
                    Row(
                      children: [
                        Expanded(
                          child: ActionButton(
                            icon: Icons.lightbulb_outline,
                            text: isWeb ? 'Dica (3 disponíveis)' : 'Dica (3)',
                            color: Colors.orange.shade700,
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ActionButton(
                            icon: Icons.cancel_outlined,
                            text: isWeb
                                ? 'Eliminar (2 disponíveis)'
                                : 'Eliminar (2)',
                            color: Colors.red.shade600,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: selectedAlternative != null ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    disabledBackgroundColor: const Color(0xFFCBD5E1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Confirmar Resposta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlternative(int index) {
    final item = alternatives[index];
    return AlternativeCard(
      label: item['label']!,
      text: item['text']!,
      isSelected: selectedAlternative == item['label'],
      onTap: () {
        setState(() {
          selectedAlternative = item['label'];
        });
      },
    );
  }
}
