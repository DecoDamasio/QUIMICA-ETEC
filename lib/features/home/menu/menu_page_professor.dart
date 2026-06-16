import 'package:flutter/material.dart';
import '../../../widgets/admin_card.dart';
import '../../../widgets/quickstatusitem.dart';
import '../../quiz/add_question.dart';
import 'cadastrar_aluno_page.dart';
import 'ranking_page.dart';
import '../../../api_service.dart';

class ProfessorMenuPage extends StatefulWidget {
  final String username;

  const ProfessorMenuPage({
    super.key,
    required this.username,
  });

  @override
  State<ProfessorMenuPage> createState() => _ProfessorMenuPageState();
}

class _ProfessorMenuPageState extends State<ProfessorMenuPage> {
  late Future<Map<String, dynamic>> dashboardFuture;

  @override
  void initState() {
    super.initState();
    dashboardFuture = ApiService.buscarDashboardProfessor();
  }

  int _toInt(dynamic value) {
    return int.tryParse(value.toString()) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD1DEE0),
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: dashboardFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text("Erro: ${snapshot.error}"),
              );
            }

            final dados = snapshot.data ?? {};

            return LayoutBuilder(
              builder: (context, constraints) {
                final bool isMobile = constraints.maxWidth < 600;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildHeader(
                        isMobile,
                        alunos: _toInt(dados["alunos"]),
                        questoes: _toInt(dados["questoes"]),
                        associacoes: _toInt(dados["associacoes"]),
                      ),

                      const SizedBox(height: 24),

                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: isMobile ? 1 : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: isMobile ? 3.0 : 2.5,
                        children: [
                          AdminCard(
                            title: "Gerenciar Alunos",
                            desc:
                                "Visualize, edite ou remova alunos cadastrados.",
                            icon: Icons.people_alt_rounded,
                            accentColor: const Color(0xFF4ADE80),
                            buttonText: "Acessar",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CadastrarAlunoPage(),
                              ),
                            ),
                          ),

                          AdminCard(
                            title: "Novas Questões",
                            desc:
                                "Crie novas perguntas para os níveis do quiz.",
                            icon: Icons.add_task_rounded,
                            accentColor: const Color(0xFF2387FF),
                            buttonText: "Criar",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AddQuestionPage(),
                              ),
                            ),
                          ),

                          AdminCard(
                            title: "Visualizar Ranking",
                            desc:
                                "Veja como está a competição entre as turmas.",
                            icon: Icons.leaderboard_rounded,
                            accentColor: Colors.orange,
                            buttonText: "Ver Ranking",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RankingAlunosScreen(),
                              ),
                            ),
                          ),

                          AdminCard(
                            title: "Estatísticas",
                            desc:
                                "Veja dados gerais do sistema e conteúdos cadastrados.",
                            icon: Icons.analytics_rounded,
                            accentColor: Colors.purple,
                            buttonText: "Relatórios",
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Alunos: ${_toInt(dados["alunos"])} | Quiz: ${_toInt(dados["questoes"])} | Associações: ${_toInt(dados["associacoes"])}",
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(
    bool isMobile, {
    required int alunos,
    required int questoes,
    required int associacoes,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: isMobile ? 25 : 30,
            backgroundColor: const Color(0xFF2387FF),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: isMobile ? 30 : 35,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Prof. ${widget.username}",
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Painel de Administração",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          if (!isMobile) ...[
            QuickStatusItem(
              icon: Icons.group,
              value: alunos.toString(),
              label: "Alunos",
            ),

            const SizedBox(width: 20),

            QuickStatusItem(
              icon: Icons.quiz,
              value: questoes.toString(),
              label: "Quiz",
            ),

            const SizedBox(width: 20),

            QuickStatusItem(
              icon: Icons.extension,
              value: associacoes.toString(),
              label: "Associações",
            ),
          ],
        ],
      ),
    );
  }
}