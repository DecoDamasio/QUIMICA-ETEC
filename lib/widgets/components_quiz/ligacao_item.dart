import 'package:flutter/material.dart';

class MatchItemCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isMatched;
  final bool isLeftAlign; // True se for a coluna da esquerda (Material)
  final VoidCallback onTap;

  const MatchItemCard({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.isMatched,
    required this.isLeftAlign,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a cor de borda e fundo baseado no estado do item
    Color borderColor = Colors.grey.shade200;
    Color backgroundColor = Colors.white;

    if (isMatched) {
      borderColor = Colors.green.shade300;
      backgroundColor = Colors.green.withOpacity(0.02);
    } else if (isSelected) {
      borderColor = Colors.blue;
      backgroundColor = Colors.blue.withOpacity(0.04);
    }

    // Estrutura do indicador circular de conexão
    Widget connectionDot = Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isMatched ? Colors.green : (isSelected ? Colors.blue : Colors.white),
        border: Border.all(
          color: isMatched ? Colors.green : (isSelected ? Colors.blue : Colors.grey.shade300),
          width: 2,
        ),
      ),
      child: (isMatched || isSelected)
          ? const Icon(Icons.check, size: 14, color: Colors.white)
          : null,
    );

    return InkWell(
      onTap: isMatched ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: isSelected || isMatched ? 2 : 1),
        ),
        child: Row(
          children: [
            if (!isLeftAlign) ...[connectionDot, const SizedBox(width: 16)],
            Expanded(
              child: Text(
                text,
                textAlign: isLeftAlign ? TextAlign.start : TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isMatched ? Colors.green.shade700 : Color(0xFF1E293B),
                ),
              ),
            ),
            if (isLeftAlign) ...[const SizedBox(width: 16), connectionDot],
          ],
        ),
      ),
    );
  }
}