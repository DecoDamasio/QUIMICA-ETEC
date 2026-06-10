import 'package:flutter/material.dart';
import '../../../widgets/universal_back_button.dart';

class GerenciarNiveisPage extends StatelessWidget {
  const GerenciarNiveisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FB),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final larguraTela = constraints.maxWidth;
            final telaPequena = larguraTela < 760;
            final telaMuitoPequena = larguraTela < 430;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: telaPequena ? 16 : 26,
                vertical: 28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cabecalhoPagina(
                    context: context,
                    telaPequena: telaPequena,
                    telaMuitoPequena: telaMuitoPequena,
                  ),

                  const SizedBox(height: 42),

                  _cardsResumo(telaPequena: telaPequena),

                  const SizedBox(height: 40),

                  NivelCard(
                    titulo: 'Nível 1 - Iniciante',
                    descricao: 'Introdução às vidrarias básicas de laboratório',
                    dificuldade: 'Básico',
                    pontuacao: '0%',
                    totalQuestoes: '20',
                    corInicial: const Color(0xFF05C46B),
                    corFinal: const Color(0xFF00B894),
                    telaPequena: telaPequena,
                  ),

                  const SizedBox(height: 32),

                  NivelCard(
                    titulo: 'Nível 2 - Intermediário',
                    descricao: 'Equipamentos e suas funções específicas',
                    dificuldade: 'Intermediário',
                    pontuacao: '60%',
                    totalQuestoes: '20',
                    corInicial: const Color(0xFF2F80ED),
                    corFinal: const Color(0xFF00BCD4),
                    telaPequena: telaPequena,
                  ),

                  const SizedBox(height: 32),

                  NivelCard(
                    titulo: 'Nível 3 - Avançado',
                    descricao: 'Procedimentos e técnicas de laboratório',
                    dificuldade: 'Avançado',
                    pontuacao: '80%',
                    totalQuestoes: '20',
                    corInicial: const Color(0xFFB000FF),
                    corFinal: const Color(0xFFFF2F92),
                    telaPequena: telaPequena,
                  ),

                  const SizedBox(height: 32),

                  NivelCard(
                    titulo: 'Nível 4 - Expert',
                    descricao: 'Desafios complexos e casos práticos',
                    dificuldade: 'Expert',
                    pontuacao: '90%',
                    totalQuestoes: '20',
                    corInicial: const Color(0xFFFF6A00),
                    corFinal: const Color(0xFFFF2D3D),
                    telaPequena: telaPequena,
                  ),

                  const SizedBox(height: 40),

                  _cardExplicacao(),

                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _cabecalhoPagina({
    required BuildContext context,
    required bool telaPequena,
    required bool telaMuitoPequena,
  }) {
    if (telaPequena) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _botaoNovoNivel()),
              const SizedBox(width: 12),
              _botaoVoltar(context),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Gerenciar Níveis',
            style: TextStyle(
              fontSize: telaMuitoPequena ? 30 : 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF24324B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Configure os níveis de dificuldade e requisitos do jogo',
            style: TextStyle(
              fontSize: 17,
              color: Color(0xFF34435E),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gerenciar Níveis',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF24324B),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Configure os níveis de dificuldade e requisitos do jogo',
                style: TextStyle(
                  fontSize: 19,
                  color: Color(0xFF34435E),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        _botaoNovoNivel(),
        const SizedBox(width: 14),
        _botaoVoltar(context),
      ],
    );
  }

  Widget _botaoNovoNivel() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.add),
      label: const Text(
        'Novo Nível',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF05C46B),
        foregroundColor: Colors.white,
        elevation: 5,
        shadowColor: Colors.black26,
        padding: const EdgeInsets.symmetric(
          horizontal: 26,
          vertical: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  Widget _botaoVoltar(BuildContext context) {
    return const UniversalBackButton(
      label: 'Voltar',
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF24324B),
      iconColor: Color(0xFF24324B),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
    );
  }

  Widget _cardsResumo({required bool telaPequena}) {
    final cards = [
      const ResumoCard(
        titulo: 'Total Níveis',
        valor: '4',
        icon: Icons.layers_outlined,
        corFundoIcone: Color(0xFFF0DFFF),
        corIcone: Color(0xFF9C27FF),
      ),
      const ResumoCard(
        titulo: 'Níveis Ativos',
        valor: '4',
        icon: Icons.lock_open_outlined,
        corFundoIcone: Color(0xFFDDFBE9),
        corIcone: Color(0xFF05C46B),
      ),
      const ResumoCard(
        titulo: 'Total Questões',
        valor: '80',
        icon: Icons.settings_outlined,
        corFundoIcone: Color(0xFFDCEBFF),
        corIcone: Color(0xFF1F73FF),
      ),
      const ResumoCard(
        titulo: 'Maior Requisito',
        valor: '90%',
        icon: Icons.emoji_events_outlined,
        corFundoIcone: Color(0xFFFFF1B8),
        corIcone: Color(0xFFFF9800),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;

        if (largura < 620) {
          return Column(
            children: cards
                .map(
                  (card) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: card,
                  ),
                )
                .toList(),
          );
        }

        if (largura < 1050) {
          return Wrap(
            spacing: 20,
            runSpacing: 20,
            children: cards
                .map(
                  (card) => SizedBox(
                    width: (largura - 20) / 2,
                    child: card,
                  ),
                )
                .toList(),
          );
        }

        return Row(
          children: cards
              .map(
                (card) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: card,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _cardExplicacao() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF9CCBFF),
          width: 1.6,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Como funcionam os níveis?',
            style: TextStyle(
              fontSize: 22,
              color: Color(0xFF163B91),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 18),
          TextoExplicacao(
            titulo: 'Pontuação Mínima:',
            texto: 'Nota necessária para desbloquear o próximo nível',
          ),
          TextoExplicacao(
            titulo: 'Status Ativo/Inativo:',
            texto: 'Controla se o nível está disponível para os alunos',
          ),
          TextoExplicacao(
            titulo: 'Total de Questões:',
            texto: 'Cada nível possui 20 questões (10 Quiz + 10 Associação)',
          ),
          TextoExplicacao(
            titulo: 'Dificuldade:',
            texto: 'Classificação visual para orientar os alunos',
          ),
          TextoExplicacao(
            titulo: 'Estrutura do Jogo:',
            texto: '4 níveis × 20 questões = 80 questões totais',
          ),
        ],
      ),
    );
  }
}

class ResumoCard extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icon;
  final Color corFundoIcone;
  final Color corIcone;

  const ResumoCard({
    super.key,
    required this.titulo,
    required this.valor,
    required this.icon,
    required this.corFundoIcone,
    required this.corIcone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: corFundoIcone,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: corIcone,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                titulo,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF24324B),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              valor,
              style: const TextStyle(
                color: Color(0xFF1F2A44),
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NivelCard extends StatelessWidget {
  final String titulo;
  final String descricao;
  final String dificuldade;
  final String pontuacao;
  final String totalQuestoes;
  final Color corInicial;
  final Color corFinal;
  final bool telaPequena;

  const NivelCard({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.dificuldade,
    required this.pontuacao,
    required this.totalQuestoes,
    required this.corInicial,
    required this.corFinal,
    required this.telaPequena,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _cabecalhoNivel(),
          Padding(
            padding: EdgeInsets.all(telaPequena ? 22 : 30),
            child: Column(
              children: [
                _informacoesNivel(),
                const SizedBox(height: 32),
                _botoesNivel(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cabecalhoNivel() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: telaPequena ? 24 : 26,
        vertical: 26,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [corInicial, corFinal],
        ),
      ),
      child: telaPequena
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _quadradoBranco(),
                    const SizedBox(width: 18),
                    Expanded(child: _tituloDescricao()),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _botaoIconeCabecalho(Icons.edit_outlined),
                    const SizedBox(width: 10),
                    _botaoIconeCabecalho(Icons.delete_outline),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                _quadradoBranco(),
                const SizedBox(width: 20),
                Expanded(child: _tituloDescricao()),
                _botaoIconeCabecalho(Icons.edit_outlined),
                const SizedBox(width: 10),
                _botaoIconeCabecalho(Icons.delete_outline),
              ],
            ),
    );
  }

  Widget _quadradoBranco() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  Widget _tituloDescricao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          descricao,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  Widget _botaoIconeCabecalho(IconData icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: const Color(0xFF24324B),
        ),
      ),
    );
  }

  Widget _informacoesNivel() {
    final itens = [
      InfoNivel(
        label: 'Dificuldade',
        valor: dificuldade,
        corFundo: const Color(0xFFF0F4F9),
        corTexto: const Color(0xFF24324B),
      ),
      InfoNivel(
        label: 'Pontuação Mínima',
        valor: pontuacao,
        corFundo: const Color(0xFFFFF4C6),
        corTexto: const Color(0xFFA84600),
      ),
      InfoNivel(
        label: 'Total de Questões',
        valor: totalQuestoes,
        subtitulo: '10 Quiz + 10 Assoc.',
        corFundo: const Color(0xFFDCEBFF),
        corTexto: const Color(0xFF003CD1),
      ),
      const InfoNivel(
        label: 'Status',
        valor: 'Ativo',
        corFundo: Color(0xFFDDFBE9),
        corTexto: Color(0xFF007A32),
      ),
    ];

    if (telaPequena) {
      return Column(
        children: itens
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: item,
              ),
            )
            .toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: itens
          .map(
            (item) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: item,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _botoesNivel() {
    final botaoEditar = Container(
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2F80ED),
            Color(0xFF08B6D4),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.edit_outlined),
        label: Text(
          'Editar Questões ($totalQuestoes)',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );

    final botaoAdicionar = SizedBox(
      height: 64,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text(
          'Adicionar Questão',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF24324B),
          side: const BorderSide(
            color: Color(0xFFC3CDDD),
            width: 1.6,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );

    if (telaPequena) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: botaoEditar,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: botaoAdicionar,
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: botaoEditar),
        const SizedBox(width: 18),
        Expanded(child: botaoAdicionar),
      ],
    );
  }
}

class InfoNivel extends StatelessWidget {
  final String label;
  final String valor;
  final String? subtitulo;
  final Color corFundo;
  final Color corTexto;

  const InfoNivel({
    super.key,
    required this.label,
    required this.valor,
    this.subtitulo,
    required this.corFundo,
    required this.corTexto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF24324B),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: corFundo,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            valor,
            style: TextStyle(
              color: corTexto,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (subtitulo != null) ...[
          const SizedBox(height: 8),
          Center(
            child: Text(
              subtitulo!,
              style: const TextStyle(
                color: Color(0xFF34435E),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class TextoExplicacao extends StatelessWidget {
  final String titulo;
  final String texto;

  const TextoExplicacao({
    super.key,
    required this.titulo,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: '• ',
              style: TextStyle(
                color: Color(0xFF0B3DCC),
              ),
            ),
            TextSpan(
              text: titulo,
              style: const TextStyle(
                color: Color(0xFF0B3DCC),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ' $texto',
              style: const TextStyle(
                color: Color(0xFF0B3DCC),
              ),
            ),
          ],
        ),
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}