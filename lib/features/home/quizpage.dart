import 'package:flutter/material.dart';
import '../../api_service.dart';
import 'menu/menu_page.dart';
import 'menu/menu_page_professor.dart';

class Question {
  final String id;
  final String title;
  final String imageUrl;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.options,
    required this.correctAnswer,
  });
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final Question currentQuestion = Question(
    id: "3",
    title: "Identifique o equipamento de laboratório apresentado na imagem:",
    imageUrl: 'assets/images/vidraria_exemplo.png', // Substitua pelo seu asset
    options: ["A) Béquer", "B) Erlenmeyer", "C) Proveta", "D) Balão Volumétrico"],
    correctAnswer: "D) Balão Volumétrico",
  );

  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/2025_plano_de_fundo_teams_op2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            'Quiz - Nível 1',
            style: TextStyle(color: Color(0xFF001A3F), fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const LinearProgressIndicator(
                  value: 0.3, // Questão 3 de 10
                  minHeight: 8,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                ),
              ),
              const SizedBox(height: 20),

              
              Row(
                children: [
                  _buildStatusCard("Pontos", "850", Icons.bolt, Colors.orange),
                  const SizedBox(width: 12),
                  _buildStatusCard("Tempo", "02:45", Icons.access_time_filled, Colors.blue),
                ],
              ),
              const SizedBox(height: 20),

              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    Text(
                      currentQuestion.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    
                    
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Icon(Icons.science, size: 80, color: Colors.cyan)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.5,
                ),
                itemCount: currentQuestion.options.length,
                itemBuilder: (context, index) {
                  final option = currentQuestion.options[index];
                  bool isSelected = _selectedOption == option;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedOption = option),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey.shade200,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected ? [BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 4)] : null,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? Colors.blue : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(option, style: const TextStyle(fontWeight: FontWeight.w500))),
                        ],
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 30),

              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _selectedOption == null ? null : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDDE4ED), // Cor desativada como na imagem
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Confirmar Resposta",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    );
  }

  
  Widget _buildStatusCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: _cardDecoration(),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}