import 'package:flutter/material.dart';
import '../../theme/app_text_styles.dart'; // Mantendo seu padrão de estilos
import '../../widgets/components_quiz/association_column.dart';
import '../../widgets/components_quiz/association_item_card.dart';
import '../../widgets/components_quiz/info_badge.dart';

class AssociationPage extends StatefulWidget {
  const AssociationPage({super.key});

  @override
  State<AssociationPage> createState() => _AssociationPageState();
}

class _AssociationPageState extends State<AssociationPage> {
  // Dados do jogo
  final List<String> _materials = ['Béquer', 'Pipeta', 'Balança', 'Funil'];
  final List<String> _functions = [
    'Pesar substâncias',
    'Transferir líquidos',
    'Medir volumes precisos',
    'Misturar soluções'
  ];

  // Mapeamento correto para validação
  final Map<String, String> _correctAnswers = {
    'Béquer': 'Misturar soluções',
    'Pipeta': 'Medir volumes precisos',
    'Balança': 'Pesar substâncias',
    'Funil': 'Transferir líquidos',
  };

  // Estado das seleções e conexões
  String? _selectedMaterial;
  String? _selectedFunction;
  Map<String, String> _connections = {}; // Material -> Função
  bool? _isAnswersCorrect;

  void _selectMaterial(String material) {
    setState(() {
      _selectedMaterial = material;
      _checkAndCreateConnection();
    });
  }

  void _selectFunction(String function) {
    setState(() {
      _selectedFunction = function;
      _checkAndCreateConnection();
    });
  }

  void _checkAndCreateConnection() {
    if (_selectedMaterial != null && _selectedFunction != null) {
      setState(() {
        // Se a função já estava conectada a outro material, remove a conexão antiga
        _connections.removeWhere((key, value) => value == _selectedFunction);
        
        // Cria a nova conexão
        _connections[_selectedMaterial!] = _selectedFunction!;
        
        // Limpa a seleção ativa
        _selectedMaterial = null;
        _selectedFunction = null;
        _isAnswersCorrect = null; // Reseta o estado de validação ao mexer
      });
    }
  }

  void _clearAll() {
    setState(() {
      _connections.clear();
      _selectedMaterial = null;
      _selectedFunction = null;
      _isAnswersCorrect = null;
    });
  }

  void _verifyAnswers() {
    if (_connections.length < _materials.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, faça todas as 4 conexões antes de verificar!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    bool allCorrect = true;
    _connections.forEach((material, function) {
      if (_correctAnswers[material] != function) {
        allCorrect = false;
      }
    });

    setState(() {
      _isAnswersCorrect = allCorrect;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(allCorrect ? 'Parabéns! Tudo correto!' : 'Algumas associações estão incorretas. Tente novamente!'),
        backgroundColor: allCorrect ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Scaffold(
      backgroundColor: const Color(0xFFEDF4F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Associação - Nível 1', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Conecte os materiais às suas funções', style: TextStyle(color: Colors.black45, fontSize: 12)),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // BADGES DE STATUS (Pontos, Tempo, Conexões)
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      const InfoBadge(icon: Icons.flash_on, iconColor: Colors.amber, label: 'Pontos', value: '520'),
                      const InfoBadge(icon: Icons.access_time, iconColor: Colors.blue, label: 'Tempo', value: '01:30'),
                      InfoBadge(
                        icon: Icons.check_circle_outline, 
                        iconColor: Colors.green, 
                        label: 'Conexões', 
                        value: '${_connections.length}/4',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // CARD DE INSTRUÇÃO "COMO FUNCIONA"
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F5FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xB3B3D7FF)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info, color: Colors.blue, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(color: Color(0xFF1E538C), fontSize: 13, height: 1.4),
                              children: [
                                TextSpan(text: 'Como funciona:\n', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: 'Clique em um item da coluna '),
                                TextSpan(text: 'Material', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: ' e depois em um item da coluna '),
                                TextSpan(text: 'Função', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: ' para criar uma conexão. Conecte todos os pares corretamente!'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // QUADRO PRINCIPAL DE ASSOCIAÇÃO
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: AssociationColumn(
                                  title: 'MATERIAL',
                                  titleColor: Colors.blue,
                                  titleIcon: Icons.inventory_2,
                                  items: _materials,
                                  selectedItem: _selectedMaterial,
                                  connections: _connections,
                                  isMaterialColumn: true,
                                  onItemTap: _selectMaterial,
                                ),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                child: AssociationColumn(
                                  title: 'FUNÇÃO',
                                  titleColor: Colors.cyan,
                                  titleIcon: Icons.track_changes,
                                  items: _functions,
                                  selectedItem: _selectedFunction,
                                  connections: _connections,
                                  isMaterialColumn: false,
                                  onItemTap: _selectFunction,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              AssociationColumn(
                                title: 'MATERIAL',
                                titleColor: Colors.blue,
                                titleIcon: Icons.inventory_2,
                                items: _materials,
                                selectedItem: _selectedMaterial,
                                connections: _connections,
                                isMaterialColumn: true,
                                onItemTap: _selectMaterial,
                              ),
                              const SizedBox(height: 24),
                              AssociationColumn(
                                title: 'FUNÇÃO',
                                titleColor: Colors.cyan,
                                titleIcon: Icons.track_changes,
                                items: _functions,
                                selectedItem: _selectedFunction,
                                connections: _connections,
                                isMaterialColumn: false,
                                onItemTap: _selectFunction,
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 24),

                  // BOTÕES DE AÇÃO INFERIORES
                  isDesktop
                      ? Row(
                          children: [
                            Expanded(child: _buildClearButton()),
                            const SizedBox(width: 16),
                            Expanded(child: _buildVerifyButton()),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildVerifyButton(),
                            const SizedBox(height: 12),
                            _buildClearButton(),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.grey[700],
        side: const BorderSide(color: Colors.black26),
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
      ),
      icon: const Icon(Icons.delete_outline),
      label: const Text('Limpar Tudo', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: _clearAll,
    );
  }

  Widget _buildVerifyButton() {
    final hasConnections = _connections.isNotEmpty;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: hasConnections ? const Color(0xFF3B82F6) : const Color(0xFFE2E8F0),
        foregroundColor: hasConnections ? Colors.white : Colors.black38,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: hasConnections ? _verifyAnswers : null,
      child: const Text('Verificar Respostas', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}