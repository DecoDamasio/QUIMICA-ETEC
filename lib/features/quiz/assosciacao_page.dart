import 'package:flutter/material.dart';
import 'package:lab_game/widgets/components_quiz/associacao_header.dart';
import 'package:lab_game/widgets/components_quiz/ligacao_item.dart';
import 'package:lab_game/widgets/universal_back_button.dart';

class AssociationPage extends StatefulWidget {
  const AssociationPage({Key? key}) : super(key: key);

  @override
  State<AssociationPage> createState() => _AssociationPageState();
}

class _AssociationPageState extends State<AssociationPage> {
  // Dados estáticos das colunas
  final List<String> materials = ['Béquer', 'Pipeta', 'Balança', 'Funil'];
  final List<String> functions = [
    'Pesar substâncias',
    'Transferir líquidos',
    'Medir volumes precisos',
    'Misturar soluções',
  ];

  // Estado de seleção atual
  String? selectedMaterial;
  String? selectedFunction;

  // Mapa para guardar os pares conectados com sucesso: { Material : Função }
  Map<String, String> completedMatches = {};

  void _handleMaterialTap(String material) {
    setState(() {
      selectedMaterial = material;
      _checkAndCreateMatch();
    });
  }

  void _handleFunctionTap(String function) {
    setState(() {
      selectedFunction = function;
      _checkAndCreateMatch();
    });
  }

  void _checkAndCreateMatch() {
    if (selectedMaterial != null && selectedFunction != null) {
      // Cria a associação direta
      completedMatches[selectedMaterial!] = selectedFunction!;
      // Limpa a seleção para o próximo par
      selectedMaterial = null;
      selectedFunction = null;
    }
  }

  void _clearAll() {
    setState(() {
      selectedMaterial = null;
      selectedFunction = null;
      completedMatches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isWeb = mediaQuery.size.width > 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),
      body: SafeArea(
        child: Column(
          children: [
            // Corpo rolável do Quiz
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isWeb ? mediaQuery.size.width * 0.12 : 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Topo: Título da atividade e botão Voltar
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
                              'Associação - Nível 1',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            Text(
                              'Conecte os materiais às suas funções',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Barra de informações dinâmicas (Header)
                    AssociationHeader(
                      points: 520,
                      time: '01:30',
                      connections: completedMatches.length,
                      totalConnections: materials.length,
                    ),
                    const SizedBox(height: 20),

                    // Card informativo azul (Como funciona)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFBFDBFE)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info, color: Colors.blue, size: 22),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF1E40AF),
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Como funciona:\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Clique em um item da coluna ',
                                  ),
                                  TextSpan(
                                    text: 'Material',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' e depois em um item da coluna ',
                                  ),
                                  TextSpan(
                                    text: 'Função',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' para criar uma conexão. Conecte todos os pares corretamente!',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Card principal com as duas colunas
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: isWeb
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _buildMaterialColumn()),
                                const SizedBox(width: 48),
                                Expanded(child: _buildFunctionColumn()),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMaterialColumn(),
                                const SizedBox(height: 32),
                                _buildFunctionColumn(),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),

            // Barra fixa inferior para os botões de ação final
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isWeb ? mediaQuery.size.width * 0.12 : 16.0,
                vertical: 20.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: isWeb ? 1 : 2,
                    child: OutlinedButton.icon(
                      onPressed: _clearAll,
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Color(0xFF475569),
                      ),
                      label: const Text(
                        'Limpar Tudo',
                        style: TextStyle(
                          color: Color(0xFF475569),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: completedMatches.length == materials.length
                          ? () {}
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        disabledBackgroundColor: const Color(0xFFCBD5E1),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Verificar Respostas',
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
          ],
        ),
      ),
    );
  }

  // Builder da coluna de Materiais
  Widget _buildMaterialColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBadgeLabel(
          'MATERIAL',
          const Color(0xFF3B82F6),
          Icons.inventory_2,
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: materials.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final mat = materials[index];
            return MatchItemCard(
              text: mat,
              isLeftAlign: true,
              isSelected: selectedMaterial == mat,
              isMatched: completedMatches.containsKey(mat),
              onTap: () => _handleMaterialTap(mat),
            );
          },
        ),
      ],
    );
  }

  // Builder da coluna de Funções
  Widget _buildFunctionColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBadgeLabel(
          'FUNÇÃO',
          const Color(0xFF06B6D4),
          Icons.track_changes,
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: functions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final func = functions[index];
            return MatchItemCard(
              text: func,
              isLeftAlign: false,
              isSelected: selectedFunction == func,
              isMatched: completedMatches.containsValue(func),
              onTap: () => _handleFunctionTap(func),
            );
          },
        ),
      ],
    );
  }

  // Widget auxiliar para as etiquetas/badges acima das colunas
  Widget _buildBadgeLabel(String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
