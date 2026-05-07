import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LevelCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final int score;
  final int stars;
  final Color accentColor;
  final bool isLocked;

  const LevelCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.progress = 0.0,
    this.score = 0,
    this.stars = 0,
    required this.accentColor,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    // cores
    final Color currentAccent = isLocked ? Colors.grey.shade300 : accentColor;
    final Color cardBorder = isLocked ? Colors.grey.shade200 : currentAccent.withOpacity(0.3);

    return Container(
      // cabe 2 por linha 
      width: (MediaQuery.of(context).size.width / 2) - 36, 
      constraints: const BoxConstraints(minWidth: 300),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cardBorder, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              isLocked 
                ? Icon(Icons.lock_outline, color: Colors.grey.shade400)
                : Row(
                    children: List.generate(3, (i) => Icon(
                      Icons.star, size: 18, color: i < stars ? Colors.amber : Colors.grey[300]
                    )),
                  ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Progresso", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              Text("${(progress * 100).toInt()}%", style: TextStyle(fontSize: 12, color: currentAccent, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[100],
            color: currentAccent,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.bolt, color: isLocked ? Colors.grey : Colors.orange, size: 18),
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
        onPressed: isLocked ? null : () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? (isLocked ? Colors.grey.shade100 : AppColors.primary) : Colors.transparent,
          foregroundColor: isPrimary ? Colors.white : AppColors.primary,
          elevation: 0,
          side: !isPrimary && !isLocked ? const BorderSide(color: AppColors.primary) : BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 12),
          disabledBackgroundColor: Colors.grey.shade100,
        ),
        child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }
}