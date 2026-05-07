import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class MenuPage extends StatefulWidget {
  final String username;

  const MenuPage({super.key, required this.username});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late final Map<String, bool> _hoveredButtons;

  @override
  void initState() {
    super.initState();
    _hoveredButtons = {
      'Iniciar Jogo': false,
      'Pontuação': false,
      'Configurações': false,
      'Sair': false,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.background),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox.shrink(),
          ),
          leadingWidth: 370,
          toolbarHeight: 130,
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Bem-vindo, ${widget.username}!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Menu Principal',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 48),
                _buildMenuButton(
                  context,
                  'Iniciar Jogo',
                  Icons.play_circle,
                  AppColors.primary,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Jogo iniciando...')),
                    );
                  },
                ),
                const SizedBox(height: 24),
                _buildMenuButton(
                  context,
                  'Pontuação',
                  Icons.leaderboard,
                  AppColors.primary,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Abrindo pontuações...')),
                    );
                  },
                ),
                const SizedBox(height: 24),
                _buildMenuButton(
                  context,
                  'Configurações',
                  Icons.settings,
                  AppColors.primary,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Abrindo configurações...')),
                    );
                  },
                ),
                const SizedBox(height: 24),
                _buildMenuButton(
                  context,
                  'Sair',
                  Icons.logout,
                  AppColors.primary,
                  () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    final bool isHovering = _hoveredButtons[label] ?? false;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredButtons[label] = true),
      onExit: (_) => setState(() => _hoveredButtons[label] = false),
      child: AnimatedScale(
        scale: isHovering ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: SizedBox(
          width: 250,
          height: 60,
          child: ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, size: 24),
            label: Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: isHovering
                  ? AppColors.tertiary
                  : AppColors.primary,
              foregroundColor: Colors.black,
              shadowColor: isHovering ? AppColors.tertiary : Colors.grey,
              elevation: isHovering ? 12 : 4,
            ),
          ),
        ),
      ),
    );
  }
}
