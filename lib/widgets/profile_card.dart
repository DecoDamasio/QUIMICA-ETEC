import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProfileCard extends StatelessWidget {
  final String username;
  final int pontos;
  final int completos;
  final int totalNiveis;
  final int ranking;

  const ProfileCard({
    super.key,
    required this.username,
    required this.pontos,
    required this.completos,
    required this.totalNiveis,
    required this.ranking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, Color(0xFF00D2FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 35,
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StatItem(
                      Icons.emoji_events_outlined,
                      "Pontos",
                      pontos.toString(),
                      Colors.orange,
                    ),

                    _StatItem(
                      Icons.check_circle_outline,
                      "Completos",
                      "$completos/$totalNiveis",
                      Colors.green,
                    ),

                    _StatItem(
                      Icons.trending_up,
                      "Ranking",
                      "#$ranking",
                      AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem(
    this.icon,
    this.label,
    this.value,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),

        const SizedBox(width: 6),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.textSecondary,
              ),
            ),

            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}