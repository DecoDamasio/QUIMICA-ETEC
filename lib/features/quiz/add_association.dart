import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../theme/app_text_styles.dart'; // Mantendo seu padrão de estilo
import '../../widgets/header_info_card.dart';
import '../../widgets/association_pair_input.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({super.key});

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers e Estados
  String? _selectedLevel;
  String _selectedType = 'Associação - Conectar';
  final TextEditingController _enunciadoController = TextEditingController();
  final TextEditingController _urlImagemController = TextEditingController();
  final TextEditingController _explicacaoController = TextEditingController();

  // Lista para armazenar os pares de associação (Máximo 4)
  final List<Map<String, TextEditingController>> _pairs = [];

  final List<String> _levels = ['Básico', 'Intermediário', 'Avançado', 'Expert'];

  @override
  void initState() {
    super.initState();
    // Inicia com pelo menos 1 par para guiar o usuário
    _addPair();
  }

  @override
  void dispose() {
    _enunciadoController.dispose();
    _urlImagemController.dispose();
    _explicacaoController.dispose();
    for (var pair in _pairs) {
      pair['item']?.dispose();
      pair['description']?.dispose();
    }
    super.dispose();
  }

  void _addPair() {
    if (_pairs.length < 4) {
      setState(() {
        _pairs.add({
          'item': TextEditingController(),
          'description': TextEditingController(),
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O limite máximo é de 4 pares de associação!'),
          backgroundColor: Colors.amber,
        ),
      );
    }
  }

  void _removePair(int index) {
    setState(() {
      _pairs[index]['item']?.dispose();
      _pairs[index]['description']?.dispose();
      _pairs.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    print("BOTAO CLICADO");

  if (!_formKey.currentState!.validate()) {
    return;
  }

  if (_selectedLevel == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Por favor, selecione um nível!'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  if (_pairs.length < 4) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Cadastre os 4 pares de associação!'),
      backgroundColor: Colors.red,
    ),
  );
  return;
}

  final nivelMap = {
    'Básico': 1,
    'Intermediário': 2,
    'Avançado': 3,
    'Expert': 4,
  };

  final questionData = {
    'nivel': nivelMap[_selectedLevel],
    'pergunta': _enunciadoController.text,
    'dica': _explicacaoController.text,
    'pares': _pairs.map((p) => {
      'item': p['item']!.text,
      'descricao': p['description']!.text,
    }).toList(),
  };

  try {

    final response = await http.post(
      Uri.parse('http://localhost/api_etec/cadastrar_associacao.php'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(questionData),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    final result = jsonDecode(response.body);

if (result["success"] == true) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Associação cadastrada com sucesso!'),
      backgroundColor: Colors.green,
    ),
  );
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(result["message"] ?? 'Erro ao cadastrar associação'),
      backgroundColor: Colors.red,
    ),
  );
}

  } catch (e) {

    print(e);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erro: $e'),
        backgroundColor: Colors.red,
      ),
    );

  }
}


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double contentWidth = screenWidth > 900 ? 800.0 : screenWidth * 0.95;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        title: const Text('Adicionar Nova Questão', style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text('Voltar'),
              style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF64748B)),
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Info Header Card
                HeaderInfoCard(width: contentWidth),
                const SizedBox(height: 24),

                // Card Principal de Dados do Formulário
                Container(
                  width: contentWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 15, offset: Offset(0, 4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Roxo do Bloco
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)]),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.add_circle_outline, color: Colors.white),
                            SizedBox(width: 8),
                            Text('Dados da Questão', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Grid Responsivo de Dropdowns (Nível e Tipo)
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final isMobile = constraints.maxWidth < 500;
                                return isMobile 
                                  ? Column(children: [_buildLevelDropdown(), const SizedBox(height: 16), _buildTypeDropdown()])
                                  : Row(children: [Expanded(child: _buildLevelDropdown()), const SizedBox(width: 16), Expanded(child: _buildTypeDropdown())]);
                              },
                            ),
                            const SizedBox(height: 20),

                            // Enunciado
                            const Text('Enunciado da Questão', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _enunciadoController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                hintText: 'Ex: Conecte cada vidraria de laboratório com sua função principal...',
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                              ),
                              validator: (value) => value!.isEmpty ? 'Insira o enunciado' : null,
                            ),
                            const SizedBox(height: 20),

                            // URL da Imagem
                            const Row(children: [Icon(Icons.image_outlined, size: 18, color: Color(0xFF64748B)), SizedBox(width: 6), Text('URL da Imagem (opcional)', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155)))]),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _urlImagemController,
                              decoration: const InputDecoration(
                                hintText: 'https://exemplo.com/imagem.jpg',
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // SEÇÃO DE PARES
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(children: [Icon(Icons.arrow_forward, color: Color(0xFF8B5CF6)), SizedBox(width: 8), Text('Pares de Associação', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)))]),
                                TextButton.icon(
                                  onPressed: _addPair,
                                  icon: const Icon(Icons.add, size: 18),
                                  label: const Text('Adicionar Par'),
                                  style: TextButton.styleFrom(foregroundColor: Colors.white, backgroundColor: const Color(0xFFA78BFA), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Banner Explicativo Roxo Claro
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: const Color(0xFFF5F3FF), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFDDD6FE))),
                              child: const Text('Como funciona: Crie pares de itens que devem ser conectados. Durante o jogo, os itens serão embaralhados e o aluno deverá fazer as conexões corretas.', style: TextStyle(fontSize: 12, color: Color(0xFF6D28D9))),
                            ),
                            const SizedBox(height: 16),

                            // Builder dos inputs de pares de associação dinâmicos
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _pairs.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                return AssociationPairInput(
                                  index: index,
                                  itemController: _pairs[index]['item']!,
                                  descriptionController: _pairs[index]['description']!,
                                  onDelete: () => _removePair(index),
                                );
                              },
                            ),
                            const SizedBox(height: 16),

                            // Banner Dica Azul Claro
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFBFDBFE))),
                              child: const Text('Dica: Os alunos deverão conectar cada item da esquerda com sua função/descrição correspondente à direita. Os pares serão embaralhados durante o jogo.', style: TextStyle(fontSize: 12, color: Color(0xFF1D4ED8))),
                            ),
                            const SizedBox(height: 20),

                            // Explicação da Resposta
                            const Text('Explicação da Resposta (opcional)', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _explicacaoController,
                              maxLines: 2,
                              decoration: const InputDecoration(
                                hintText: 'Forneça uma explicação educativa sobre a resposta correta...',
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Botões de Ação Inferiores (Salvar e Cancelar)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                                  child: const Text('Cancelar', style: TextStyle(color: Color(0xFF64748B))),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton.icon(
                                  onPressed: _submitForm,
                                  icon: const Icon(Icons.save_outlined, color: Colors.white),
                                  label: const Text('Salvar Questão', style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(children: [Icon(Icons.layers_outlined, size: 18, color: Color(0xFF64748B)), SizedBox(width: 6), Text('Nível', style: TextStyle(fontWeight: FontWeight.w600))]),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedLevel,
          hint: const Text('Selecione o nível'),
          decoration: const InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
          items: _levels.map((lvl) => DropdownMenuItem(value: lvl, child: Text(lvl))).toList(),
          onChanged: (value) => setState(() => _selectedLevel = value),
        ),
      ],
    );
  }

  Widget _buildTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(children: [Icon(Icons.assignment_outlined, size: 18, color: Color(0xFF64748B)), SizedBox(width: 6), Text('Tipo de Questão', style: TextStyle(fontWeight: FontWeight.w600))]),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedType,
          decoration: const InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
          items: [DropdownMenuItem(value: _selectedType, child: Text(_selectedType))],
          onChanged: null, // Desabilitado conforme a imagem (Fixo em Associação)
        ),
      ],
    );
  }
}