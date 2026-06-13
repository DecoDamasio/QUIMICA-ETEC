import 'package:flutter/material.dart';

class QuizActionButtons extends StatelessWidget {
  final int hints;
  final int eliminations;
  final VoidCallback? onHintPressed;
  final VoidCallback? onEliminatePressed;

  const QuizActionButtons({
    super.key,
    required this.hints,
    required this.eliminations,
    this.onHintPressed,
    this.onEliminatePressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth > 600;

    final buttons = [
      _buildActionButton(
        icon: Icons.lightbulb_outline,
        label: 'Dica ($hints disponíveis)',
        color: const Color(0xFFD97706), // Amarelo escuro / Amber do print
        backgroundColor: const Color(0xFFFFFBEB),
        onPressed: onHintPressed,
      ),
      _buildActionButton(
        icon: Icons.cancel_outlined,
        label: 'Eliminar ($eliminations disponíveis)',
        color: const Color(0xFFEA580C), // Laranja escuro / Orange
        backgroundColor: const Color(0xFFFFF7ED),
        onPressed: onEliminatePressed,
      ),
    ];

    if (isWide) {
      return Row(
        children: [
          Expanded(child: buttons[0]),
          const SizedBox(width: 12),
          Expanded(child: buttons[1]),
        ],
      );
    }

    return Column(
      children: [
        buttons[0],
        const SizedBox(height: 12),
        buttons[1],
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color backgroundColor,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: color.withOpacity(0.4)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ).buildActionButtonChild(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

// Extensão utilitária rápida para reaproveitar propriedades do OutlinedButton com segurança
extension on ButtonStyle {
  Widget buildActionButtonChild({required VoidCallback? onPressed, required Widget child}) {
    return OutlinedButton(onPressed: onPressed, style: this, child: child);
  }
}