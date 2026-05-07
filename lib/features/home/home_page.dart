import 'package:flutter/material.dart';
import 'package:lab_game/widgets/buttons.dart';
import 'menu/menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _loginController;
  late final TextEditingController _senhaController;
  bool _isHovering = false;

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
        // O AppBar foi removido para o título ficar harmonioso com o login no body
        body: _LoginForm(
          loginController: _loginController,
          senhaController: _senhaController,
          isHovering: _isHovering,
          onHoverChanged: (hovering) => setState(() => _isHovering = hovering),
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
    required this.onHoverChanged,
  });

  final TextEditingController loginController;
  final TextEditingController senhaController;
  final bool isHovering;
  final ValueChanged<bool> onHoverChanged;

  @override
  Widget build(BuildContext context) {
    // Definimos 300 como a largura padrão para as duas caixas ficarem iguais
    const double containerWidth = 300.0;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // =========================================================
              // NOVO CABEÇALHO (CAIXA BRANCA COM LOGO E TITULO)
              // =========================================================
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
                    // MUDANÇA AQUI: Coloque o caminho da sua imagem abaixo
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/Gemini_Generated_Image_4uz34j4uz34j4uz3 - 01.png', // <-- MUDE O NOME DO ARQUIVO AQUI
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        // Se a imagem não for encontrada, mostra um ícone de erro
                        errorBuilder: (context, error, stackTrace) => 
                          const Icon(Icons.science, size: 50, color: Colors.cyan),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'Lab Game',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Cor escura para contraste
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20), // Espaço entre as caixas

              // =========================================================
              // CAIXA DE LOGIN ORIGINAL
              // =========================================================
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
                    const Text(
                      'Login',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: loginController,
                      decoration: const InputDecoration(
                        labelText: 'Login',
                        hintText: 'Digite seu usuário',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
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
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
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

  void _handleLogin(BuildContext context) {
    if (loginController.text.isEmpty || senhaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha login e senha!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuPage(username: loginController.text),
        ),
      );
    }
  }
}
