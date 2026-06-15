import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/level_card.dart';
import '../../../widgets/profile_card.dart';
import '../../../widgets/custom_header.dart';
import '../../quiz/association_page.dart';
import '../../quiz/quiz_page.dart';
import '../../../api_service.dart';

class MenuPage extends StatefulWidget {
  final String username;
  final int alunoId;

  const MenuPage({
    super.key,
    required this.username,
    required this.alunoId,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late Future<Map<String, dynamic>> dashboardFuture;

  @override
  void initState() {
    super.initState();
    dashboardFuture = ApiService.buscarDashboard(widget.alunoId);
  }

  int _toInt(dynamic value) {
    return int.tryParse(value.toString()) ?? 0;
  }

  int _calcularEstrelas(int progresso) {
    if (progresso >= 100) return 3;
    if (progresso >= 50) return 2;
    if (progresso > 0) return 1;
    return 0;
  }

  void _recarregarDashboard() {
    setState(() {
      dashboardFuture = ApiService.buscarDashboard(widget.alunoId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder<Map<String, dynamic>>(
        future: dashboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("Nenhum dado encontrado"));
          }

          final dados = snapshot.data!;
          final niveis = dados["niveis"] as List<dynamic>;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CustomHeader(
                    title: "Seu Progresso",
                    subtitle: "Continue sua jornada de aprendizado!",
                  ),

                  const SizedBox(height: 32),

                  ProfileCard(
                    username: widget.username,
                    pontos: _toInt(dados["pontuacao_total"]),
                    completos: _toInt(dados["completos"]),
                    totalNiveis: _toInt(dados["total_niveis"]),
                    ranking: _toInt(dados["ranking"]),
                  ),

                  const SizedBox(height: 32),

                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: List.generate(
                      niveis.length,
                      (index) {
                        final nivel = niveis[index];

                        final int progresso = _toInt(nivel["progresso"]);
                        final int pontuacao = _toInt(nivel["pontuacao"]);

                        final bool nivelAnteriorConcluido = index == 0
                            ? true
                            : _toInt(niveis[index - 1]["concluido"]) == 1;

                        final bool bloqueado = !nivelAnteriorConcluido;

                        return LevelCard(
                          title: "Nível ${index + 1}",
                          subtitle: nivel["nome"] ?? "",
                          progress: progresso / 100,
                          score: pontuacao,
                          stars: _calcularEstrelas(progresso),
                          isLocked: bloqueado,
                          accentColor: progresso >= 100
                              ? AppColors.success
                              : AppColors.primary,
                          onQuizPressed: () async {
                            final atualizou = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => QuizPage(
                                  alunoId: widget.alunoId,
                                  nivelId: _toInt(nivel["id"]),
                                ),
                              ),
                            );

                            if (atualizou == true) {
                              _recarregarDashboard();
                            }
                          },
                          onAssociacaoPressed: () async {
                            final atualizou = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => AssociationPage(
                                  alunoId: widget.alunoId,
                                  nivelId: _toInt(nivel["id"]),
                                ),
                              ),
                            );

                            if (atualizou == true) {
                              _recarregarDashboard();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}