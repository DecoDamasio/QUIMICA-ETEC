import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.tertiary),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: const Text('Sair'),
        ),
      ],
    );
  }
}