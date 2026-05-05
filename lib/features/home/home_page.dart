import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logos_cps_governo_com_slogan_horizontal_cor.png',
            height: 400,
            width: 450,
          ),
        ),
        leadingWidth: 360,
        title: const Text('Lab Game'),
        titleTextStyle: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          height: 3.5
        ),
        centerTitle: true,
        toolbarHeight: 100, // altura customizada
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _loginController,
                  decoration: InputDecoration(
                    labelText: 'Login',
                    hintText: 'Digite seu usuário',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Digite sua senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    print('Login: ${_loginController.text}');
                    print('Senha: ${_senhaController.text}');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Entrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}