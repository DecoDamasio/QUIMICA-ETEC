import 'package:flutter/material.dart';

class AssociationItemCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isConnected;
  final bool isMaterialColumn;
  final VoidCallback onTap;

  const AssociationItemCard({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isConnected,
    required this.isMaterialColumn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Definição dinâmica de cores com base no estado do card
    Color borderColor = const Color(0xFFE2E8F0);
    Color backgroundColor = Colors.white;
    
    if (isSelected) {
      borderColor = Colors.blue;
      backgroundColor = Colors.blue.withOpacity(0.03);
    } else if (isConnected) {
      borderColor = Colors.green.withOpacity(0.5);
      backgroundColor = Colors.green.withOpacity(0.01);
    }

    // Alinhamento do círculo (esquerda na função, direita no material)
    Widget circleMarker = Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.blue : (isConnected ? Colors.green : const Color(0xFFCBD5E1)),
          width: isSelected || isConnected ? 6 : 2,
        ),
        color: isSelected ? Colors.blue : (isConnected ? Colors.green : Colors.transparent),
      ),
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1.5),
        ),
        child: Row(
          children: [
            if (!isMaterialColumn) ...[
              circleMarker,
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: isConnected ? Colors.black45 : Colors.black87,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  decoration: isConnected ? TextDecoration.none : null,
                ),
              ),
            ),
            if (isMaterialColumn) ...[
              const SizedBox(width: 16),
              circleMarker,
            ],
          ],
        ),
      ),
    );
  }
}