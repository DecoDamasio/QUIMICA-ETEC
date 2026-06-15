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

    dashboardFuture =
        ApiService.buscarDashboard(widget.alunoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder<Map<String, dynamic>>(
        future: dashboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro: ${snapshot.error}",
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text("Nenhum dado encontrado"),
            );
          }

          final dados = snapshot.data!;
          final niveis =
              dados["niveis"] as List<dynamic>;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CustomHeader(
                    title: "Seu Progresso",
                    subtitle:
                        "Continue sua jornada de aprendizado!",
                  ),

                  const SizedBox(height: 32),

                  ProfileCard(
                    username: widget.username,
                    pontos:
                        dados["pontuacao_total"] ?? 0,
                    completos:
                        dados["completos"] ?? 0,
                    totalNiveis:
                        dados["total_niveis"] ?? 0,
                    ranking:
                        dados["ranking"] ?? 0,
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

                        return LevelCard(
                          title:
                              "Nível ${index + 1}",

                          subtitle:
                              nivel["nome"] ?? "",

                          progress:
                              ((nivel["progresso"] ?? 0)
                                      as num)
                                  .toDouble() /
                              100,

                          score:
                              nivel["pontuacao"] ?? 0,

                          stars:
                              ((((nivel["progresso"] ??
                                              0)
                                          as num)
                                      .toDouble()) ~/
                                  34),

                          isLocked:
                              index > 0 &&
                              (nivel["concluido"] ??
                                      0) ==
                                  0,

                          accentColor:
                              AppColors.primary,

                          onQuizPressed: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const QuizPage(),
                              ),
                            );
                          },

                          onAssociacaoPressed:
                              () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const AssociationPage(),
                              ),
                            );
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