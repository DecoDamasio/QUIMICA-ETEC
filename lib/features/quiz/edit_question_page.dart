import 'package:flutter/material.dart';
import '../../widgets/components_quiz/navigation_widgets.dart';
import '../../widgets/components_quiz/form_widgets.dart';
import '../../widgets/components_quiz/info_widgets.dart';

class EditQuestionPage extends StatefulWidget {
  const EditQuestionPage({super.key});

  @override
  State<EditQuestionPage> createState() => _EditQuestionPageState();
}

class _EditQuestionPageState extends State<EditQuestionPage> {
  int _currentLevel = 1;
  int _currentQuestionIndex = 1;
  bool _isQuestionActive = true;

  // Controllers para os campos
  final _enunciadoController = TextEditingController(text: "Identifique a vidraria de laboratório...");
  final _urlImageController = TextEditingController(text: "https://images.unsplash.com/...");
  final _alt1Controller = TextEditingController(text: "Béquer");
  final _alt2Controller = TextEditingController(text: "Erlenmeyer");
  final _alt3Controller = TextEditingController(text: "Proveta");
  final _alt4Controller = TextEditingController(text: "Bureta");
  final _explicacaoController = TextEditingController(text: "O Béquer é um recipiente cilíndrico...");
  String _selectedCorrect = "Alternativa 1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Fundo cinza claro
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Editar Questão - Nível 1", style: TextStyle(color: Colors.black87, fontSize: 18)),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            label: const Text("Excluir", style: TextStyle(color: Colors.red)),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Voltar"),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.grey[700]),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000), // Limite para Web
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Seleção de Nível
                LevelSelector(
                  currentLevel: _currentLevel,
                  onLevelChanged: (lvl) => setState(() => _currentLevel = lvl),
                ),
                const SizedBox(height: 20),

                // 2. Navegação entre questões
                QuestionNavigator(
                  currentIndex: _currentQuestionIndex,
                  onPrev: () {},
                  onNext: () {},
                ),
                const SizedBox(height: 24),

                // 3. Dados da Questão
                SectionCard(
                  title: "Dados da Questão",
                  icon: Icons.edit_document,
                  accentColor: Colors.purple,
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text("Questão Ativa", style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text("Esta questão está disponível para os alunos"),
                        value: _isQuestionActive,
                        activeColor: Colors.green,
                        onChanged: (val) => setState(() => _isQuestionActive = val),
                      ),
                      const Divider(),
                      const SizedBox(height: 16),
                      ResponsiveRow(
                        children: [
                          // Nível e Tipo (Bloqueados conforme pedido)
                          Expanded(child: CustomDropdown(label: "Nível", value: "Nível 1 - Básico", enabled: false)),
                          const SizedBox(width: 16),
                          Expanded(child: CustomDropdown(label: "Tipo de Questão", value: "Quiz - Identificação", enabled: false)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(label: "Enunciado da Questão", controller: _enunciadoController, maxLines: 3),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 4. URL Imagem
                SectionCard(
                  title: "URL da Imagem (opcional)",
                  icon: Icons.image,
                  accentColor: Colors.blue,
                  child: Column(
                    children: [
                      CustomTextField(label: "Link da Imagem", controller: _urlImageController),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          "https://images.unsplash.com/photo-1512187863486-a88fbdcd1bd1?q=80&w=400",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(height: 100, color: Colors.grey[200], child: const Icon(Icons.broken_image)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 5. Alternativas
                SectionCard(
                  title: "Alternativas de Resposta",
                  icon: Icons.list,
                  accentColor: Colors.cyan,
                  child: Column(
                    children: [
                      CustomTextField(label: "Alternativa 1", controller: _alt1Controller),
                      const SizedBox(height: 12),
                      CustomTextField(label: "Alternativa 2", controller: _alt2Controller),
                      const SizedBox(height: 12),
                      CustomTextField(label: "Alternativa 3", controller: _alt3Controller),
                      const SizedBox(height: 12),
                      CustomTextField(label: "Alternativa 4", controller: _alt4Controller),
                      const SizedBox(height: 20),
                      CustomDropdown(
                        label: "Resposta Correta",
                        value: _selectedCorrect,
                        items: const ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"],
                        onChanged: (val) => setState(() => _selectedCorrect = val!),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(label: "Explicação da Resposta (opcional)", controller: _explicacaoController, maxLines: 3),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 6. Rodapé de Info e Botões
                const InfoGrid(),
                const SizedBox(height: 32),
                const ActionFooter(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget auxiliar para linha responsiva
class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  const ResponsiveRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return Column(children: children);
      }
      return Row(children: children);
    });
  }
}