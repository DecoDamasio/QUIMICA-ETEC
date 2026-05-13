import 'package:flutter/material.dart';

// Widget auxiliar para as caixinhas de seleção
class UserTypeCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;
  final double height;

  const UserTypeCard({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.width = 75.0,
    this.height = 75.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: width,
        height: height,
        decoration: BoxDecoration(
          // Cor ciana clara se selecionado, cinza se não
          color: isSelected ? const Color(0xFFE0F7FA) : Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.cyan : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? Colors.cyan[800] : Colors.grey[600],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.cyan[900] : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
