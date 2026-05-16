import 'package:flutter/material.dart';

class CadastrarAlunoPage extends StatefulWidget {
  const CadastrarAlunoPage({super.key});

  @override
  State<CadastrarAlunoPage> createState() => _CadastrarAlunoPageState();
}

class _CadastrarAlunoPageState extends State<CadastrarAlunoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();
  final TextEditingController dataNascimentoController = TextEditingController();

  String? serieSelecionada;

  final List<String> series = [
    '6º Ano',
    '7º Ano',
    '8º Ano',
    '9º Ano',
    '1º Ano Ensino Médio',
    '2º Ano Ensino Médio',
    '3º Ano Ensino Médio',
  ];

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    dataNascimentoController.dispose();
    super.dispose();
  }

  void cadastrarAluno() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aluno cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      debugPrint('Nome: ${nomeController.text}');
      debugPrint('E-mail: ${emailController.text}');
      debugPrint('Senha: ${senhaController.text}');
      debugPrint('Série: $serieSelecionada');
      debugPrint('Data de nascimento: ${dataNascimentoController.text}');
    }
  }

  Future<void> selecionarData() async {
    final dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime(2010),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (dataSelecionada != null) {
      final dia = dataSelecionada.day.toString().padLeft(2, '0');
      final mes = dataSelecionada.month.toString().padLeft(2, '0');
      final ano = dataSelecionada.year.toString();

      setState(() {
        dataNascimentoController.text = '$dia/$mes/$ano';
      });
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
            final telaPequena = larguraTela < 700;
            final telaMuitoPequena = larguraTela < 430;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: telaPequena ? 16 : 24,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cabecalhoPagina(telaPequena, telaMuitoPequena),
                  SizedBox(height: telaPequena ? 28 : 45),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 960),
                      child: _cardFormulario(telaPequena, telaMuitoPequena),
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

  Widget _cabecalhoPagina(bool telaPequena, bool telaMuitoPequena) {
    if (telaPequena) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: _botaoVoltar(),
          ),
          const SizedBox(height: 18),
          Text(
            'Cadastrar Novo Aluno',
            style: TextStyle(
              fontSize: telaMuitoPequena ? 28 : 34,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF24324B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Preencha os dados para criar uma nova conta de estudante',
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
                'Cadastrar Novo Aluno',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF24324B),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Preencha os dados para criar uma nova conta de estudante',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF34435E),
                ),
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
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
      label: const Text('Voltar'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF24324B),
        elevation: 4,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  Widget _cardFormulario(bool telaPequena, bool telaMuitoPequena) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
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
                  campoTexto(
                    label: 'Nome Completo',
                    hint: 'Ex: João da Silva',
                    icon: Icons.person_outline,
                    controller: nomeController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Digite o nome completo';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 26),

                  campoTexto(
                    label: 'E-mail',
                    hint: 'aluno@escola.com.br',
                    icon: Icons.email_outlined,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Digite o e-mail';
                      }

                      if (!value.contains('@')) {
                        return 'Digite um e-mail válido';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 26),

                  _linhaResponsiva(
                    telaPequena: telaPequena,
                    primeiro: campoTexto(
                      label: 'Senha',
                      hint: 'Mínimo 6 caracteres',
                      icon: Icons.lock_outline,
                      controller: senhaController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite a senha';
                        }

                        if (value.length < 6) {
                          return 'A senha deve ter no mínimo 6 caracteres';
                        }

                        return null;
                      },
                    ),
                    segundo: campoTexto(
                      label: 'Confirmar Senha',
                      hint: 'Repita a senha',
                      icon: Icons.lock_outline,
                      controller: confirmarSenhaController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirme a senha';
                        }

                        if (value != senhaController.text) {
                          return 'As senhas não conferem';
                        }

                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 26),

                  _linhaResponsiva(
                    telaPequena: telaPequena,
                    primeiro: campoDropdownSerie(),
                    segundo: campoDataNascimento(),
                  ),

                  const SizedBox(height: 30),

                  _caixaNota(),

                  const SizedBox(height: 45),

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
        horizontal: telaMuitoPequena ? 22 : 26,
        vertical: 26,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2F80ED),
            Color(0xFF08B6D4),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.person_add_alt_1,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Informações do Aluno',
              style: TextStyle(
                fontSize: telaMuitoPequena ? 22 : 26,
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
      return Column(
        children: [
          primeiro,
          const SizedBox(height: 26),
          segundo,
        ],
      );
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

  Widget _caixaNota() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF9CCBFF),
          width: 1.5,
        ),
      ),
      child: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Nota: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B3DCC),
              ),
            ),
            TextSpan(
              text:
                  'O aluno receberá um e-mail com as credenciais de acesso após o cadastro ser concluído.',
              style: TextStyle(
                color: Color(0xFF0B3DCC),
              ),
            ),
          ],
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _botoesFormulario(bool telaPequena) {
    final botaoCadastrar = Container(
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2F80ED),
            Color(0xFF08B6D4),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton.icon(
        onPressed: cadastrarAluno,
        icon: const Icon(Icons.save_outlined),
        label: const Text(
          'Cadastrar Aluno',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
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
          side: const BorderSide(
            color: Color(0xFFC3CDDD),
            width: 1.7,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Cancelar',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );

    if (telaPequena) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: botaoCadastrar,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: botaoCancelar,
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 4,
          child: botaoCadastrar,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: botaoCancelar,
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
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelCampo(label: label, icon: icon),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          decoration: _decoracaoCampo(hint),
        ),
      ],
    );
  }

  Widget campoDropdownSerie() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelCampo(
          label: 'Série',
          icon: Icons.school_outlined,
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: serieSelecionada,
          isExpanded: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Selecione a série';
            }
            return null;
          },
          decoration: _decoracaoCampo(null),
          hint: const Text(
            'Selecione a série',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 17),
          ),
          items: series.map((serie) {
            return DropdownMenuItem<String>(
              value: serie,
              child: Text(
                serie,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              serieSelecionada = value;
            });
          },
        ),
      ],
    );
  }

  Widget campoDataNascimento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelCampo(
          label: 'Data de Nascimento',
          icon: Icons.calendar_today_outlined,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: dataNascimentoController,
          readOnly: true,
          onTap: selecionarData,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Selecione a data';
            }
            return null;
          },
          decoration: _decoracaoCampo(
            'dd/mm/aaaa',
            suffixIcon: const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFF8B98AA),
            ),
          ),
        ),
      ],
    );
  }

  Widget _labelCampo({
    required String label,
    IconData? icon,
  }) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 22,
            color: const Color(0xFF24324B),
          ),
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

  InputDecoration _decoracaoCampo(String? hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: suffixIcon,
      hintStyle: const TextStyle(
        color: Colors.black45,
        fontSize: 17,
      ),
      filled: true,
      fillColor: const Color(0xFFF8FAFD),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 22,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFDDE5F0),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF2F80ED),
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
    );
  }
}