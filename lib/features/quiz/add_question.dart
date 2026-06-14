import 'package:flutter/material.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/layout_widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({super.key});

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _enunciadoController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _alt1Controller = TextEditingController();
  final _alt2Controller = TextEditingController();
  final _alt3Controller = TextEditingController();
  final _alt4Controller = TextEditingController();
  final _explicacaoController = TextEditingController();

  String? _selectedLevel;
  String? _selectedType = 'Quiz - Identificação';
  int? _correctAlternative;

  final List<String> _levels = ['Básico', 'Intermediário', 'Avançado', 'Expert'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Define a largura máxima para Web, mas ocupa quase tudo no Mobile
    final contentWidth = screenWidth > 900 ? screenWidth * 0.7 : screenWidth * 0.95;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // Fundo levemente cinza/lavanda
      appBar: AppBar(
        title: const Text("Adicionar Nova Questão", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            width: contentWidth,
            child: Column(
              children: [
                SectionCard(
                  child: Column(
                    children: [
                      const SectionHeader(title: "Dados da Questão", icon: Icons.add),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            // Linha de Nível e Tipo (Responsiva)
                            LayoutBuilder(builder: (context, constraints) {
                              if (constraints.maxWidth > 600) {
                                return Row(
                                  children: [
                                    Expanded(child: _buildLevelDropdown()),
                                    const SizedBox(width: 20),
                                    Expanded(child: _buildTypeDropdown()),
                                  ],
                                );
                              } else {
                                return Column(children: [
                                  _buildLevelDropdown(),
                                  _buildTypeDropdown()
                                ]);
                              }
                            }),
                            CustomTextField(
                              label: "Enunciado da Questão",
                              hint: "Ex: Identifique a vidraria apresentada...",
                              controller: _enunciadoController,
                              maxLines: 3,
                            ),
                            CustomTextField(
                              label: "URL da Imagem (opcional)",
                              hint: "https://exemplo.com/imagem.png",
                              controller: _imageUrlController,
                            ),
                            
                            const Divider(height: 40),
                            
                            const Row(
                              children: [
                                Icon(Icons.check_circle_outline, color: Colors.green),
                                SizedBox(width: 10),
                                Text("Alternativas de Resposta", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(label: "Alternativa 1", hint: "Resposta A", controller: _alt1Controller),
                            CustomTextField(label: "Alternativa 2", hint: "Resposta B", controller: _alt2Controller),
                            CustomTextField(label: "Alternativa 3", hint: "Resposta C", controller: _alt3Controller),
                            CustomTextField(label: "Alternativa 4", hint: "Resposta D", controller: _alt4Controller),
                            
                            const Divider(height: 40),

                            CustomDropdown<int>(
                              label: "Resposta Correta",
                              value: _correctAlternative,
                              items: List.generate(4, (index) => DropdownMenuItem(
                                value: index + 1,
                                child: Text("Alternativa ${index + 1}"),
                              )),
                              onChanged: (val) => setState(() => _correctAlternative = val),
                            ),
                            
                            CustomTextField(
                              label: "Explicação da Resposta (opcional)",
                              hint: "Forneça uma explicação educativa...",
                              controller: _explicacaoController,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Botões de Ação
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _saveQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text("Salvar Questão", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelDropdown() {
    return CustomDropdown<String>(
      label: "Nível",
      value: _selectedLevel,
      items: _levels.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
      onChanged: (val) => setState(() => _selectedLevel = val),
    );
  }

  Widget _buildTypeDropdown() {
    return CustomDropdown<String>(
      label: "Tipo de Questão",
      value: _selectedType,
      items: const [DropdownMenuItem(value: 'Quiz - Identificação', child: Text('Quiz - Identificação'))],
      onChanged: (val) => setState(() => _selectedType = val),
    );
  }

  Future<void> _saveQuestion() async {
  if (_selectedLevel == null ||
      _enunciadoController.text.isEmpty ||
      _correctAlternative == null) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Preencha os campos obrigatórios!"),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }

  try {

    final nivelMap = {
      'Básico': 1,
      'Intermediário': 2,
      'Avançado': 3,
      'Expert': 4,
    };

    final respostaCorreta =
        ['A', 'B', 'C', 'D'][_correctAlternative! - 1];

    final response = await http.post(
      Uri.parse(
        'http://127.0.0.1/api_etec/cadastrar_questao.php',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nivel': nivelMap[_selectedLevel],
        'pergunta': _enunciadoController.text,
        'imagem': _imageUrlController.text,
        'alt_a': _alt1Controller.text,
        'alt_b': _alt2Controller.text,
        'alt_c': _alt3Controller.text,
        'alt_d': _alt4Controller.text,
        'resposta_correta': respostaCorreta,
        'dica': _explicacaoController.text,
        'eliminar_1': 'A',
        'eliminar_2': 'D'
      }),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Questão cadastrada com sucesso!"),
        backgroundColor: Colors.green,
      ),
    );

  } catch (e) {

    print(e);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Erro: $e"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
}