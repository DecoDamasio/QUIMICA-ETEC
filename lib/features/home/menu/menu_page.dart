import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/level_card.dart';
import '../../../widgets/profile_card.dart';
import '../../../widgets/custom_header.dart';

class MenuPage extends StatelessWidget {
  final String username;

  const MenuPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            children: [
              const CustomHeader(
                title: "Seu Progresso",
                subtitle: "Continue sua jornada de aprendizado!",
              ),
              const SizedBox(height: 32),
              ProfileCard(username: username),
              const SizedBox(height: 32),
              LevelCard(
                title: "Nível 1",
                subtitle: "Vidrarias Básicas",
                progress: 1.0,
                score: 850,
                stars: 3,
                accentColor: Colors.green,
              ),
              const SizedBox(height: 24),
              LevelCard(
                title: "Nível 2",
                subtitle: "Equipamentos de Medição",
                progress: 0.45,
                score: 520,
                stars: 1,
                accentColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}