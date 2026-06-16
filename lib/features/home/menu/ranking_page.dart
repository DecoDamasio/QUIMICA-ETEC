import 'package:flutter/material.dart';
import '../../../widgets/aluno.dart';
import '../../../widgets/nota_badge.dart';
import '../../../widgets/acoes_botoes.dart';
import '../../../widgets/universal_back_button.dart';
import '../../../api_service.dart';

class RankingAlunosScreen extends StatefulWidget {
  const RankingAlunosScreen({Key? key}) : super(key: key);

  @override
  State<RankingAlunosScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingAlunosScreen> {
  // dados ficticios (por enquanto)
  List<Aluno> alunos = [];
bool carregando = true;

@override
void initState() {
  super.initState();
  carregarAlunos();
}

Future<void> carregarAlunos() async {
  try {
    final dados = await ApiService.buscarRanking();

    setState(() {
      alunos = dados.map<Aluno>((item) {
        return Aluno(
          id: int.parse(item["id"].toString()),
          nome: item["nome"].toString(),
          nivel1: int.parse(item["nivel1"].toString()),
          nivel2: int.parse(item["nivel2"].toString()),
          nivel3: int.parse(item["nivel3"].toString()),
          nivel4: int.parse(item["nivel4"].toString()),
        );
      }).toList();

      carregando = false;
    });
  } catch (e) {
    print("Erro ao carregar alunos: $e");

    setState(() {
      carregando = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    
    if (carregando) {
  return const Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text(
          'Painel Acadêmico',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF26324D),
        elevation: 0,
        leading: const UniversalBackButton(
          iconMode: true,
          iconColor: Colors.white,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // define o tamanho da tela
          bool isMobile = constraints.maxWidth < 600;

          return SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 12.0 : 24.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // cabeçalho do ranking
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFF26324D),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.emoji_events_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Ranking',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // responsividade
                  isMobile ? _buildMobileCards() : _buildDesktopTable(),

                  // rodapé responsivo
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Flex(
                      direction: isMobile ? Axis.vertical : Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: isMobile
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Mostrando ${alunos.length} de ${alunos.length} alunos',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        if (isMobile)
                          const SizedBox(height: 12), // Espaçamento no celular
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton(
                              onPressed: null,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.black12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                'Anterior',
                                style: TextStyle(color: Colors.black38),
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.black26),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Text(
                                    'Próximo',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 14,
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
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

  // responsividade ok (web)
  Widget _buildDesktopTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF595959),
          fontSize: 12,
        ),
        columns: const [
          DataColumn(label: Text('ALUNO')),
          DataColumn(label: Text('NÍVEL 1')),
          DataColumn(label: Text('NÍVEL 2')),
          DataColumn(label: Text('NÍVEL 3')),
          DataColumn(label: Text('NÍVEL 4')),
          DataColumn(label: Text('MÉDIA')),
          DataColumn(label: Text('AÇÕES')),
        ],
        rows: alunos.map((aluno) {
          return DataRow(
            cells: [
              DataCell(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      aluno.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF262626),
                      ),
                    ),
                    Text(
                      'ID: #${aluno.id}',
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ),
              DataCell(NotaBadge(nota: aluno.nivel1)),
              DataCell(NotaBadge(nota: aluno.nivel2)),
              DataCell(NotaBadge(nota: aluno.nivel3)),
              DataCell(NotaBadge(nota: aluno.nivel4)),
              DataCell(
                Text(
                  '${aluno.media}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF262626),
                    fontSize: 15,
                  ),
                ),
              ),
              DataCell(
                AcoesBotoes(
                  onVisualizar: () => print('Visualizar ${aluno.nome}'),
                  onEditar: () => print('Editar ${aluno.nome}'),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // responsividade ok
  Widget _buildMobileCards() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: alunos.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
      itemBuilder: (context, index) {
        final aluno = alunos[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // nome dos alunos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        aluno.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF262626),
                        ),
                      ),
                      Text(
                        'ID: #${aluno.id}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  AcoesBotoes(
                    onVisualizar: () => print('Visualizar ${aluno.nome}'),
                    onEditar: () => print('Editar ${aluno.nome}'),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // linha de niveis
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMobileNivelItem('N1', aluno.nivel1),
                  _buildMobileNivelItem('N2', aluno.nivel2),
                  _buildMobileNivelItem('N3', aluno.nivel3),
                  _buildMobileNivelItem('N4', aluno.nivel4),

                  // média
                  Column(
                    children: [
                      const Text(
                        'MÉDIA',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${aluno.media}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF26324D),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Auxiliar para alinhar as notas etiquetadas no modo mobile
  Widget _buildMobileNivelItem(String label, int? nota) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        NotaBadge(nota: nota),
      ],
    );
  }
}
