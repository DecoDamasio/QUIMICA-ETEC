import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<void> cadastrarAluno() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse("http://localhost/api_etec/cadastrar_aluno.php"),
          body: {
            "nome": nomeController.text,
            "email": emailController.text,
            "senha": senhaController.text,
            "data_nascimento": dataNascimentoController.text,
            "serie": serieSelecionada ?? "",
          },
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.body),
              backgroundColor: Colors.green,
            ),
          );

          nomeController.clear();
          emailController.clear();
          senhaController.clear();
          confirmarSenhaController.clear();
          dataNascimentoController.clear();

          setState(() {
            serieSelecionada = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Erro ao conectar com o servidor"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 700,
            padding: const EdgeInsets.all(30),
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Cadastrar Novo Aluno',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF24324B),
                    ),
                  ),

                  const SizedBox(height: 35),

                  campoTexto(
                    label: 'Nome Completo',
                    hint: 'Ex: João da Silva',
                    controller: nomeController,
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Digite o nome completo';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 25),

                  campoTexto(
                    label: 'E-mail',
                    hint: 'nome.sobrenome@aluno.cps.gov.br',
                    controller: emailController,
                    icon: Icons.email_outlined,
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

                  const SizedBox(height: 25),

                  campoTexto(
                    label: 'Senha',
                    hint: 'Mínimo 6 caracteres',
                    controller: senhaController,
                    icon: Icons.lock_outline,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite a senha';
                      }

                      if (value.length < 6) {
                        return 'Mínimo 6 caracteres';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 25),

                  campoTexto(
                    label: 'Confirmar Senha',
                    hint: 'Repita a senha',
                    controller: confirmarSenhaController,
                    icon: Icons.lock_outline,
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

                  const SizedBox(height: 25),

                  campoDropdownSerie(),

                  const SizedBox(height: 25),

                  campoDataNascimento(),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
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
                        backgroundColor: const Color(0xFF2F80ED),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF24324B),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icon != null ? Icon(icon) : null,
            filled: true,
            fillColor: const Color(0xFFF8FAFD),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget campoDropdownSerie() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Série',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF24324B),
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: serieSelecionada,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF8FAFD),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          hint: const Text('Selecione a série'),
          items: series.map((serie) {
            return DropdownMenuItem<String>(
              value: serie,
              child: Text(serie),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              serieSelecionada = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Selecione a série';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget campoDataNascimento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data de Nascimento',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF24324B),
          ),
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
          decoration: InputDecoration(
            hintText: 'dd/mm/aaaa',
            suffixIcon: const Icon(Icons.calendar_month_outlined),
            filled: true,
            fillColor: const Color(0xFFF8FAFD),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}