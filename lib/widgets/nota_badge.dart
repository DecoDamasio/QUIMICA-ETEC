import 'package:flutter/material.dart';

class NotaBadge extends StatelessWidget {
  final int? nota;

  const NotaBadge({Key? key, this.nota}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // se não xistir nota mostra um traço
    if (nota == null) {
      return const Text(
        '—', 
        style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold)
      );
    }

    // cores
    Color backgroundColor;
    Color textColor;

    if (nota! >= 80) {
      backgroundColor = const Color(0xFFE6F7ED); // Verde bem claro
      textColor = const Color(0xFF24B25B);       // Verde escuro
    } else if (nota! >= 60) {
      backgroundColor = const Color(0xFFFFF7E6); // Amarelo bem claro
      textColor = const Color(0xFFFAAD14);       // Amarelo escuro
    } else {
      backgroundColor = const Color(0xFFF5F5F5); // Cinza bem claro
      textColor = const Color(0xFF8C8C8C);       // Cinza escuro
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: textColor.withOpacity(0.3), width: 1),
      ),
      child: Text(
        '$nota',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}