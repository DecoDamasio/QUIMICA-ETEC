import 'package:flutter/material.dart';
import '../../../widgets/universal_back_button.dart';

class AdicionarQuestaoPage extends StatefulWidget {
  const AdicionarQuestaoPage({super.key});

  @override
  State<AdicionarQuestaoPage> createState() => _AdicionarQuestaoPageState();
}

class _AdicionarQuestaoPageState extends State<AdicionarQuestaoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController enunciadoController = TextEditingController();
  final TextEditingController urlImagemController = TextEditingController();
  final TextEditingController explicacaoController = TextEditingController();

  String? nivelSelecionado;
  String? tipoSelecionado;

  final List<String> niveis = ['Nível 1', 'Nível 2', 'Nível 3', 'Nível 4'];

  final List<String> tipos = ['Quiz', 'Associação'];

  @override
  void dispose() {
    enunciadoController.dispose();
    urlImagemController.dispose();
    explicacaoController.dispose();
    super.dispose();
  }

  void salvarQuestao() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Questão salva com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      debugPrint('Nível: $nivelSelecionado');
      debugPrint('Tipo: $tipoSelecionado');
      debugPrint('Enunciado: ${enunciadoController.text}');
      debugPrint('URL da imagem: ${urlImagemController.text}');
      debugPrint('Explicação: ${explicacaoController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FB),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final larguraTela = constraints.maxWidth;
            final telaPequena = larguraTela < 750;
            final telaMuitoPequena = larguraTela < 430;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: telaPequena ? 16 : 30,
                vertical: 22,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cabecalhoPagina(
                    telaPequena: telaPequena,
                    telaMuitoPequena: telaMuitoPequena,
                  ),

                  const SizedBox(height: 34),

                  _cardEstrutura(telaPequena: telaPequena),

                  const SizedBox(height: 40),

                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1120),
                      child: _cardFormulario(
                        telaPequena: telaPequena,
                        telaMuitoPequena: telaMuitoPequena,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _cabecalhoPagina({
    required bool telaPequena,
    required bool telaMuitoPequena,
  }) {
    if (telaPequena) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(alignment: Alignment.centerRight, child: _botaoVoltar()),
          const SizedBox(height: 18),
          Text(
            'Adicionar Nova Questão',
            style: TextStyle(
              fontSize: telaMuitoPequena ? 28 : 34,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF24324B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Crie questões de quiz ou associação para os alunos',
            style: TextStyle(fontSize: 17, color: Color(0xFF34435E)),
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
                'Adicionar Nova Questão',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF24324B),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Crie questões de quiz ou associação para os alunos',
                style: TextStyle(fontSize: 19, color: Color(0xFF34435E)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        _botaoVoltar(),
      ],
    );
  }

  Widget _botaoVoltar() {
    return const UniversalBackButton(
      label: 'Voltar',
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF24324B),
      iconColor: Color(0xFF24324B),
    );
  }

  Widget _cardEstrutura({required bool telaPequena}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(telaPequena ? 22 : 26),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F2FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2C4FF), width: 1.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.layers_outlined, color: Color(0xFF6418B8), size: 28),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Estrutura de Questões por Nível',
                  style: TextStyle(
                    color: Color(0xFF6418B8),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          if (telaPequena)
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ItemEstrutura(
                  cor: Color(0xFF05C46B),
                  titulo: '10 Questões de Quiz',
                  descricao: 'Identificação de vidrarias e equipamentos',
                ),
                SizedBox(height: 14),
                _ItemEstrutura(
                  cor: Color(0xFFA855F7),
                  titulo: '10 Questões de Associação',
                  descricao: 'Conectar itens às suas funções',
                ),
              ],
            )
          else
            const Row(
              children: [
                Expanded(
                  child: _ItemEstrutura(
                    cor: Color(0xFF05C46B),
                    titulo: '10 Questões de Quiz',
                    descricao: 'Identificação de vidrarias e equipamentos',
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: _ItemEstrutura(
                    cor: Color(0xFFA855F7),
                    titulo: '10 Questões de Associação',
                    descricao: 'Conectar itens às suas funções',
                  ),
                ),
              ],
            ),

          const SizedBox(height: 16),

          const Text(
            'Total: 20 questões por nível • 4 níveis • 80 questões no jogo completo',
            style: TextStyle(fontSize: 15, color: Color(0xFF6A00D4)),
          ),
        ],
      ),
    );
  }

  Widget _cardFormulario({
    required bool telaPequena,
    required bool telaMuitoPequena,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _topoCard(telaMuitoPequena),
          Padding(
            padding: EdgeInsets.all(telaPequena ? 24 : 40),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _linhaResponsiva(
                    telaPequena: telaPequena,
                    primeiro: campoDropdown(
                      label: 'Nível',
                      hint: 'Selecione o nível',
                      icon: Icons.layers_outlined,
                      valor: nivelSelecionado,
                      itens: niveis,
                      onChanged: (value) {
                        setState(() {
                          nivelSelecionado = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Selecione o nível';
                        }
                        return null;
                      },
                    ),
                    segundo: campoDropdown(
                      label: 'Tipo de Questão',
                      hint: 'Selecione o tipo',
                      icon: Icons.quiz_outlined,
                      valor: tipoSelecionado,
                      itens: tipos,
                      onChanged: (value) {
                        setState(() {
                          tipoSelecionado = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Selecione o tipo';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  campoTexto(
                    label: 'Enunciado da Questão',
                    hint: 'Digite o enunciado da questão...',
                    controller: enunciadoController,
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Digite o enunciado da questão';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  campoTexto(
                    label: 'URL da Imagem (opcional)',
                    hint: 'https://exemplo.com/imagem.jpg',
                    icon: Icons.image_outlined,
                    controller: urlImagemController,
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  campoTexto(
                    label: 'Explicação da Resposta (opcional)',
                    hint:
                        'Forneça uma explicação educativa sobre a resposta correta...',
                    controller: explicacaoController,
                    maxLines: 4,
                    validator: (value) {
                      return null;
                    },
                  ),

                  const SizedBox(height: 56),

                  _botoesFormulario(telaPequena),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topoCard(bool telaMuitoPequena) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: telaMuitoPequena ? 24 : 30,
        vertical: 28,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB000FF), Color(0xFF235DF4)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.add, color: Colors.white, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Dados da Questão',
              style: TextStyle(
                fontSize: telaMuitoPequena ? 23 : 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _linhaResponsiva({
    required bool telaPequena,
    required Widget primeiro,
    required Widget segundo,
  }) {
    if (telaPequena) {
      return Column(children: [primeiro, const SizedBox(height: 28), segundo]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: primeiro),
        const SizedBox(width: 20),
        Expanded(child: segundo),
      ],
    );
  }

  Widget _botoesFormulario(bool telaPequena) {
    final botaoSalvar = Container(
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFB000FF), Color(0xFF235DF4)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton.icon(
        onPressed: salvarQuestao,
        icon: const Icon(Icons.save_outlined),
        label: const Text(
          'Salvar Questão',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );

    final botaoCancelar = SizedBox(
      height: 64,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF24324B),
          side: const BorderSide(color: Color(0xFFC3CDDD), width: 1.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text('Cancelar', style: TextStyle(fontSize: 18)),
      ),
    );

    if (telaPequena) {
      return Column(
        children: [
          SizedBox(width: double.infinity, child: botaoSalvar),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: botaoCancelar),
        ],
      );
    }

    return Row(
      children: [
        Expanded(flex: 5, child: botaoSalvar),
        const SizedBox(width: 20),
        Expanded(child: botaoCancelar),
      ],
    );
  }

  Widget campoDropdown({
    required String label,
    required String hint,
    required IconData icon,
    required String? valor,
    required List<String> itens,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelCampo(label: label, icon: icon),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: valor,
          isExpanded: true,
          validator: validator,
          decoration: _decoracaoCampo(null),
          hint: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 17),
          ),
          items: itens.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget campoTexto({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    IconData? icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelCampo(label: label, icon: icon),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          decoration: _decoracaoCampo(hint),
        ),
      ],
    );
  }

  Widget _labelCampo({required String label, IconData? icon}) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 22, color: const Color(0xFF24324B)),
          const SizedBox(width: 10),
        ],
        Expanded(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF24324B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _decoracaoCampo(String? hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black45, fontSize: 17),
      filled: true,
      fillColor: const Color(0xFFF8FAFD),
      contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDDE5F0), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF8A2BFF), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}

class _ItemEstrutura extends StatelessWidget {
  final Color cor;
  final String titulo;
  final String descricao;

  const _ItemEstrutura({
    required this.cor,
    required this.titulo,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(color: cor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A00D4),
                  ),
                ),
                TextSpan(
                  text: ' - $descricao',
                  style: const TextStyle(color: Color(0xFF6A00D4)),
                ),
              ],
            ),
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ],
    );
  }
}
