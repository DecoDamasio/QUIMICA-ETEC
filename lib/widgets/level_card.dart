import 'package:flutter/material.dart';
import '../../theme/app_colors.dart'; 
class LevelCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress; // 0.0 a 1.0
  final int score;
  final int stars;
  final Color accentColor;

  const LevelCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.score,
    this.stars = 0,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withOpacity(0.2), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ],
              ),
              Row(
                children: List.generate(3, (i) => Icon(
                  Icons.star, 
                  size: 20, 
                  color: i < stars ? Colors.amber : Colors.grey[300]
                )),
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Progresso", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              Text("${(progress * 100).toInt()}%", 
                style: TextStyle(fontSize: 12, color: accentColor, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            color: accentColor,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.bolt, color: Colors.orange, size: 18),
              const Text(" Pontuação: ", style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              Text("$score", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildBtn("Quiz", isPrimary: true),
              const SizedBox(width: 10),
              _buildBtn("Associação", isPrimary: false),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBtn(String label, {required bool isPrimary}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : Colors.transparent,
          foregroundColor: isPrimary ? Colors.white : AppColors.primary,
          elevation: 0,
          side: isPrimary ? BorderSide.none : const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ),
    );
  }
}