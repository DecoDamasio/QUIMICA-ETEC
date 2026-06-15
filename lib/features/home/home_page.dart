import 'package:flutter/material.dart';
import 'package:lab_game/widgets/buttons.dart';
import 'package:lab_game/widgets/UserType.dart';
import '../../theme/app_text_styles.dart';
import '../../api_service.dart';
import 'menu/menu_page.dart';
import 'menu/menu_page_professor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _loginController;
  late final TextEditingController _senhaController;
  bool _isHovering = false;
  bool _isStudentSelected = true;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _senhaController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/2025_plano_de_fundo_teams_op2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _LoginForm(
          loginController: _loginController,
          senhaController: _senhaController,
          isHovering: _isHovering,
          isStudentSelected: _isStudentSelected,
          onUserTypeChanged: (isStudent) =>
              setState(() => _isStudentSelected = isStudent),
          onHoverChanged: (hovering) =>
              setState(() => _isHovering = hovering),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.loginController,
    required this.senhaController,
    required this.isHovering,
    required this.isStudentSelected,
    required this.onUserTypeChanged,
    required this.onHoverChanged,
  });

  final TextEditingController loginController;
  final TextEditingController senhaController;
  final bool isHovering;
  final bool isStudentSelected;
  final ValueChanged<bool> onUserTypeChanged;
  final ValueChanged<bool> onHoverChanged;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth = screenWidth > 600 ? 300.0 : screenWidth * 0.9;
    final double cardSize = screenWidth > 600 ? 75.0 : 60.0;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // CABEÇALHO
              Container(
                width: containerWidth,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/Gemini_Generated_Image_4uz34j4uz34j4uz3 - 01.png',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.science, size: 50, color: Colors.cyan),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text('Lab Game', style: AppTextStyles.pageTitle),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // CAIXA LOGIN
              Container(
                width: containerWidth,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UserTypeCard(
                          label: 'Aluno',
                          icon: Icons.school_outlined,
                          isSelected: isStudentSelected,
                          onTap: () => onUserTypeChanged(true),
                          width: cardSize,
                          height: cardSize,
                        ),
                        const SizedBox(width: 12),
                        UserTypeCard(
                          label: 'Professor',
                          icon: Icons.co_present_outlined,
                          isSelected: !isStudentSelected,
                          onTap: () => onUserTypeChanged(false),
                          width: cardSize,
                          height: cardSize,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text("(Tipo de Usuário)",
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                    const SizedBox(height: 16),
                    const Text('Login',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    TextField(
                      controller: loginController,
                      decoration: const InputDecoration(
                        labelText: 'Login',
                        hintText: 'Digite seu usuário',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: senhaController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Digite sua senha',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 24),
                    MouseRegion(
                      onEnter: (_) => onHoverChanged(true),
                      onExit: (_) => onHoverChanged(false),
                      child: AnimatedScale(
                        scale: isHovering ? 1.05 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: SizedBox(
                          width: double.infinity,
                          child: WhiteOutlineButton(
                            text: 'Entrar',
                            onPressed: () => _handleLogin(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) async {
  if (loginController.text.isEmpty || senhaController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Por favor, preencha login e senha!'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  String tipo = isStudentSelected ? "aluno" : "professor";

  // LOGIN DE DESENVOLVIMENTO
  if (loginController.text == "dev" &&
      senhaController.text == "123") {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isStudentSelected
            ? const MenuPage(
                username: "Desenvolvedor",
                alunoId: 1,
              )
            : const ProfessorMenuPage(
                username: "Desenvolvedor",
              ),
      ),
    );

    return;
  }

  var resultado = await ApiService.login(
    tipo,
    loginController.text,
    senhaController.text,
  );

  if (resultado["status"] == "sucesso") {

    final String username =
        resultado["nome"] ?? loginController.text;

    final int alunoId =
        int.parse(resultado["id"].toString());

    bool isProfessor =
        resultado["tipo"] == "professor";

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isProfessor
            ? ProfessorMenuPage(
                username: username,
              )
            : MenuPage(
                username: username,
                alunoId: alunoId,
              ),
      ),
    );

  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login ou senha incorretos!'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
}