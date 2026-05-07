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
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const CustomHeader(
                title: "Seu Progresso",
                subtitle: "Continue sua jornada de aprendizado!",
              ),
              const SizedBox(height: 32),
              ProfileCard(username: username),
              const SizedBox(height: 32),
              
              // 2 por linha (Wrap para responsividade)
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  const LevelCard(
                    title: "Nível 1",
                    subtitle: "Vidrarias Básicas",
                    progress: 1.0,
                    score: 850,
                    stars: 3,
                    accentColor: AppColors.success,
                  ),
                  const LevelCard(
                    title: "Nível 2",
                    subtitle: "Equipamentos de Medição",
                    progress: 0.45,
                    score: 520,
                    stars: 1,
                    accentColor: AppColors.primary,
                  ),
                  const LevelCard(
                    title: "Nível 3",
                    subtitle: "Equipamentos de Aquecimento",
                    isLocked: true,
                    accentColor: AppColors.primary,
                  ),
                  const LevelCard(
                    title: "Nível 4",
                    subtitle: "Equipamentos de Segurança",
                    isLocked: true,
                    accentColor: AppColors.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}