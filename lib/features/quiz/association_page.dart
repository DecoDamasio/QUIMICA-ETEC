import 'dart:math';
import 'package:flutter/material.dart';
import '../../api_service.dart';
import '../../widgets/components_quiz/association_column.dart';
import '../../widgets/components_quiz/info_badge.dart';

class AssociationPage extends StatefulWidget {
  final int alunoId;
  final int nivelId;

  const AssociationPage({
    super.key,
    required this.alunoId,
    required this.nivelId,
  });

  @override
  State<AssociationPage> createState() => _AssociationPageState();
}

class _AssociationPageState extends State<AssociationPage> {
  late Future<Map<String, dynamic>> associacaoFuture;

  List<String> _materials = [];
  List<String> _functions = [];
  Map<String, String> _correctAnswers = {};

  String? _selectedMaterial;
  String? _selectedFunction;

  Map<String, String> _connections = {};

  int _points = 0;
  int _acertos = 0;

  @override
  void initState() {
    super.initState();
    associacaoFuture = ApiService.buscarAssociacao(widget.nivelId);
  }

  void _carregarDados(Map<String, dynamic> questao) {
    final pares = questao["pares"] as List<dynamic>;

    _materials = pares.map((p) => p["material"].toString()).toList();

    _functions = pares.map((p) => p["funcao"].toString()).toList();

    _functions.shuffle(Random());

    _correctAnswers = {
      for (var p in pares)
        p["material"].toString(): p["funcao"].toString(),
    };
  }

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
      _connections.removeWhere(
        (key, value) => value == _selectedFunction,
      );

      _connections[_selectedMaterial!] = _selectedFunction!;

      _selectedMaterial = null;
      _selectedFunction = null;
    }
  }

  void _clearAll() {
    setState(() {
      _connections.clear();
      _selectedMaterial = null;
      _selectedFunction = null;
    });
  }

  Future<void> _verifyAnswers() async {
    if (_connections.length < _materials.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Faça todas as 4 conexões antes de verificar!',
          ),
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

    if (allCorrect) {
      await ApiService.adicionarPontos(
        widget.alunoId,
        widget.nivelId,
        50,
      );

      setState(() {
        _points += 50;
        _acertos++;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Correto! +50 pontos'),
          backgroundColor: Colors.green,
        ),
      );

      if (_acertos >= 5) {
        await ApiService.finalizarNivel(
          widget.alunoId,
          widget.nivelId,
          "associacao",
        );

        Navigator.pop(context, true);
        return;
      }

      setState(() {
        _connections.clear();
        _selectedMaterial = null;
        _selectedFunction = null;
        associacaoFuture =
            ApiService.buscarAssociacao(widget.nivelId);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Algumas associações estão incorretas. Tente novamente!',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
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
            Text(
              'Associação - Nível ${widget.nivelId}',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Conecte os materiais às suas funções',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: associacaoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Erro: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!["success"] != true) {
            return const Center(
              child: Text("Nenhuma associação encontrada"),
            );
          }

          final questao = snapshot.data!["questao"];
          _carregarDados(questao);

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          InfoBadge(
                            icon: Icons.flash_on,
                            iconColor: Colors.amber,
                            label: 'Pontos',
                            value: '$_points',
                          ),
                          const InfoBadge(
                            icon: Icons.access_time,
                            iconColor: Colors.blue,
                            label: 'Tempo',
                            value: '00:00',
                          ),
                          InfoBadge(
                            icon: Icons.check_circle_outline,
                            iconColor: Colors.green,
                            label: 'Conexões',
                            value:
                                '${_connections.length}/${_materials.length}',
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6F5FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xB3B3D7FF),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info,
                              color: Colors.blue,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                questao["pergunta"].toString(),
                                style: const TextStyle(
                                  color: Color(0xFF1E538C),
                                  fontSize: 13,
                                  height: 1.4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: isDesktop
                            ? Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AssociationColumn(
                                      title: 'MATERIAL',
                                      titleColor: Colors.blue,
                                      titleIcon:
                                          Icons.inventory_2,
                                      items: _materials,
                                      selectedItem:
                                          _selectedMaterial,
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
                                      titleIcon:
                                          Icons.track_changes,
                                      items: _functions,
                                      selectedItem:
                                          _selectedFunction,
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
                                    titleIcon:
                                        Icons.inventory_2,
                                    items: _materials,
                                    selectedItem:
                                        _selectedMaterial,
                                    connections: _connections,
                                    isMaterialColumn: true,
                                    onItemTap: _selectMaterial,
                                  ),
                                  const SizedBox(height: 24),
                                  AssociationColumn(
                                    title: 'FUNÇÃO',
                                    titleColor: Colors.cyan,
                                    titleIcon:
                                        Icons.track_changes,
                                    items: _functions,
                                    selectedItem:
                                        _selectedFunction,
                                    connections: _connections,
                                    isMaterialColumn: false,
                                    onItemTap: _selectFunction,
                                  ),
                                ],
                              ),
                      ),

                      const SizedBox(height: 24),

                      isDesktop
                          ? Row(
                              children: [
                                Expanded(child: _buildClearButton()),
                                const SizedBox(width: 16),
                                Expanded(child: _buildVerifyButton()),
                              ],
                            )
                          : Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
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
          );
        },
      ),
    );
  }

  Widget _buildClearButton() {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.grey[700],
        side: const BorderSide(color: Colors.black26),
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
      ),
      icon: const Icon(Icons.delete_outline),
      label: const Text(
        'Limpar Tudo',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: _clearAll,
    );
  }

  Widget _buildVerifyButton() {
    final hasConnections = _connections.isNotEmpty;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: hasConnections
            ? const Color(0xFF3B82F6)
            : const Color(0xFFE2E8F0),
        foregroundColor:
            hasConnections ? Colors.white : Colors.black38,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: hasConnections ? _verifyAnswers : null,
      child: const Text(
        'Verificar Respostas',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}