import 'package:flutter/material.dart';
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
          image: AssetImage('assets/images/2025_plano_de_fundo_teams_op1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox.shrink(),
          ),
          leadingWidth: 360,
          title: const Text('Lab Game'),
          titleTextStyle: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            height: 3.5,
          ),
          centerTitle: true,
          toolbarHeight: 100,
        ),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(
                  0x1A000000,
                ), // Otimizado: 0.1 * 255 = 25.5 ≈ 26 em hex
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
                  child: ElevatedButton(
                    onPressed: () => _handleLogin(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: isHovering
                          ? const Color(
                              0x33FF0000,
                            ) // Otimizado: Colors.red.withOpacity(0.2)
                          : Colors.white,
                      shadowColor: isHovering ? Colors.red : Colors.grey,
                      elevation: isHovering ? 12 : 4,
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
