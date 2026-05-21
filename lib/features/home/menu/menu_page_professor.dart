import 'package:flutter/material.dart';
import '../../../widgets/admin_card.dart';
import '../../../widgets/quickstatusitem.dart';
import 'cadastrar_aluno_page.dart';
import 'gerenciar_niveis_page.dart';
import 'ranking_page.dart';

class ProfessorMenuPage extends StatelessWidget {
  final String username;

  const ProfessorMenuPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD1DEE0),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // --- HEADER ---
                  _buildHeader(isMobile),

                  const SizedBox(height: 24),

                  // --- GRID DE AÇÕES ---
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isMobile ? 1 : 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    // proporçao pra mobile
                    childAspectRatio: isMobile ? 2.1 : 1.4,
                    children: [
                      AdminCard(
                        title: "Gerenciar Alunos",
                        desc: "Visualize, edite ou remova alunos cadastrados.",
                        icon: Icons.people_alt_rounded,
                        accentColor: const Color(0xFF4ADE80),
                        buttonText: "Acessar",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CadastrarAlunoPage(),
                          ),
                        ),
                      ),
                      AdminCard(
                      title: "Novas Questões",
                      desc: "Crie novas perguntas para os níveis do quiz.",
                      icon: Icons.add_task_rounded,
                      accentColor: const Color(0xFF2387FF),
                      buttonText: "Criar",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GerenciarNiveisPage(),
                        ),
                      ),
                    ),
                      AdminCard(
                        title: "Visualizar Ranking",
                        desc: "Veja como está a competição entre as turmas.",
                        icon: Icons.leaderboard_rounded,
                        accentColor: Colors.orange,
                        buttonText: "Ver Ranking",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RankingAlunosScreen(),
                          ),
                        ),  
                      ),
                      AdminCard(
                        title: "Estatísticas",
                        desc: "Relatórios de acertos e tempo de uso.",
                        icon: Icons.analytics_rounded,
                        accentColor: Colors.purple,
                        buttonText: "Relatórios",
                        onTap: () => print("Navegar para Stats"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // widget cabeçalho
  Widget _buildHeader(bool isMobile) {
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
                  "Prof. $username",
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Painel de Administração",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          // mostrar menos informações no mobile
          if (!isMobile) ...[
            const QuickStatusItem(
              icon: Icons.group,
              value: "42",
              label: "Alunos",
            ),
            const SizedBox(width: 20),
            const QuickStatusItem(
              icon: Icons.quiz,
              value: "12",
              label: "Ativos",
            ),
          ],
        ],
      ),
    );
  }
}
