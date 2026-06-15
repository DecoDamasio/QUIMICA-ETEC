import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../widgets/association_pair_input.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/layout_widgets.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({super.key});

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _formKey = GlobalKey<FormState>();
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

  final List<String> _levels = [
    'Básico',
    'Intermediário',
    'Avançado',
    'Expert',
  ];

  final List<Map<String, TextEditingController>> _pairs = [];

  @override
  void initState() {
    super.initState();
    _addPair();
  }

  @override
  void dispose() {
    _enunciadoController.dispose();
    _imageUrlController.dispose();
    _alt1Controller.dispose();
    _alt2Controller.dispose();
    _alt3Controller.dispose();
    _alt4Controller.dispose();
    _explicacaoController.dispose();
    for (final pair in _pairs) {
      pair['item']?.dispose();
      pair['description']?.dispose();
    }
    super.dispose();
  }

  void _addPair() {
    if (_pairs.length >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O limite máximo é de 4 pares de associação!'),
          backgroundColor: Colors.amber,
        ),
      );
      return;
    }

    setState(() {
      _pairs.add({
        'item': TextEditingController(),
        'description': TextEditingController(),
      });
    });
  }

  void _removePair(int index) {
    setState(() {
      _pairs[index]['item']?.dispose();
      _pairs[index]['description']?.dispose();
      _pairs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Define a largura máxima para Web, mas ocupa quase tudo no Mobile
    final contentWidth = screenWidth > 900
        ? screenWidth * 0.7
        : screenWidth * 0.95;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // Fundo levemente cinza/lavanda
      appBar: AppBar(
        title: const Text(
          "Adicionar Nova Questão",
          style: TextStyle(color: Colors.black87),
        ),
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
                      const SectionHeader(
                        title: "Dados da Questão",
                        icon: Icons.add,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            // Linha de Nível e Tipo (Responsiva)
                            LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth > 600) {
                                  return Row(
                                    children: [
                                      Expanded(child: _buildLevelDropdown()),
                                      const SizedBox(width: 20),
                                      Expanded(child: _buildTypeDropdown()),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      _buildLevelDropdown(),
                                      _buildTypeDropdown(),
                                    ],
                                  );
                                }
                              },
                            ),
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

                            if (_selectedType == 'Quiz - Identificação') ...[
                              const Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Alternativas de Resposta",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                label: "Alternativa 1",
                                hint: "Resposta A",
                                controller: _alt1Controller,
                              ),
                              CustomTextField(
                                label: "Alternativa 2",
                                hint: "Resposta B",
                                controller: _alt2Controller,
                              ),
                              CustomTextField(
                                label: "Alternativa 3",
                                hint: "Resposta C",
                                controller: _alt3Controller,
                              ),
                              CustomTextField(
                                label: "Alternativa 4",
                                hint: "Resposta D",
                                controller: _alt4Controller,
                              ),
                              const Divider(height: 40),
                              CustomDropdown<int>(
                                label: "Resposta Correta",
                                value: _correctAlternative,
                                items: List.generate(
                                  4,
                                  (index) => DropdownMenuItem(
                                    value: index + 1,
                                    child: Text("Alternativa ${index + 1}"),
                                  ),
                                ),
                                onChanged: (val) =>
                                    setState(() => _correctAlternative = val),
                              ),
                            ] else ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Color(0xFF8B5CF6),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Pares de Associação',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton.icon(
                                    onPressed: _addPair,
                                    icon: const Icon(Icons.add, size: 18),
                                    label: const Text('Adicionar Par'),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: const Color(0xFFA78BFA),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F3FF),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFDDD6FE),
                                  ),
                                ),
                                child: const Text(
                                  'Crie pares de itens e funções/descriptions. Durante o jogo, os itens serão embaralhados e o aluno deverá fazer as conexões corretas.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6D28D9),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              if (_pairs.isEmpty)
                                const Text(
                                  'Adicione pelo menos um par de associação.',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _pairs.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  return AssociationPairInput(
                                    index: index,
                                    itemController: _pairs[index]['item']!,
                                    descriptionController:
                                        _pairs[index]['description']!,
                                    onDelete: () => _removePair(index),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFBFDBFE),
                                  ),
                                ),
                                child: const Text(
                                  'Dica: cada par deve conter um item de um lado e sua função ou descrição do outro lado.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF1D4ED8),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],

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
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _saveQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Salvar Questão",
                        style: TextStyle(color: Colors.white),
                      ),
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
      items: _levels
          .map((l) => DropdownMenuItem(value: l, child: Text(l)))
          .toList(),
      onChanged: (val) => setState(() => _selectedLevel = val),
    );
  }

  Widget _buildTypeDropdown() {
    return CustomDropdown<String>(
      label: "Tipo de Questão",
      value: _selectedType,
      items: const [
        DropdownMenuItem(
          value: 'Quiz - Identificação',
          child: Text('Quiz - Identificação'),
        ),
        DropdownMenuItem(
          value: 'Associação - Conectar',
          child: Text('Associação - Conectar'),
        ),
      ],
      onChanged: (val) {
        setState(() {
          _selectedType = val;
          _correctAlternative = null;
          if (val == 'Associação - Conectar' && _pairs.isEmpty) {
            _addPair();
          }
        });
      },
    );
  }

  Future<void> _saveQuestion() async {
    if (_selectedLevel == null || _enunciadoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha os campos obrigatórios!"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_selectedType == 'Quiz - Identificação') {
      if (_correctAlternative == null ||
          _alt1Controller.text.isEmpty ||
          _alt2Controller.text.isEmpty ||
          _alt3Controller.text.isEmpty ||
          _alt4Controller.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Preencha todas as alternativas e escolha a resposta correta!"),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
    } else if (_selectedType == 'Associação - Conectar') {
      if (_pairs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Adicione pelo menos um par de associação!"),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      for (final pair in _pairs) {
        if (pair['item']!.text.isEmpty || pair['description']!.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Preencha todos os campos dos pares de associação!"),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }
      }
    }

    try {
      final nivelMap = {
        'Básico': 1,
        'Intermediário': 2,
        'Avançado': 3,
        'Expert': 4,
      };

      final requestBody = {
        'nivel': nivelMap[_selectedLevel],
        'tipo': _selectedType,
        'pergunta': _enunciadoController.text,
        'imagem': _imageUrlController.text,
        'dica': _explicacaoController.text,
      };

      if (_selectedType == 'Quiz - Identificação') {
        final respostaCorreta = ['A', 'B', 'C', 'D'][_correctAlternative! - 1];
        requestBody.addAll({
          'alt_a': _alt1Controller.text,
          'alt_b': _alt2Controller.text,
          'alt_c': _alt3Controller.text,
          'alt_d': _alt4Controller.text,
          'resposta_correta': respostaCorreta,
          'eliminar_1': 'A',
          'eliminar_2': 'D',
        });
      } else {
        requestBody['pares'] = _pairs
            .map((pair) => {
                  'item': pair['item']!.text,
                  'descricao': pair['description']!.text,
                })
            .toList();
      }

      final response = await http.post(
        Uri.parse('http://127.0.0.1/api_etec/cadastrar_questao.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
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
        SnackBar(content: Text("Erro: $e"), backgroundColor: Colors.red),
      );
    }
  }
}
