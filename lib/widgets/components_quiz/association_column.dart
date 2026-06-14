import 'package:flutter/material.dart';
import 'association_item_card.dart';

class AssociationColumn extends StatelessWidget {
  final String title;
  final Color titleColor;
  final IconData titleIcon;
  final List<String> items;
  final String? selectedItem;
  final Map<String, String> connections;
  final bool isMaterialColumn;
  final ValueChanged<String> onItemTap;

  const AssociationColumn({
    super.key,
    required this.title,
    required this.titleColor,
    required this.titleIcon,
    required this.items,
    required this.selectedItem,
    required this.connections,
    required this.isMaterialColumn,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Badge de Identificação da Coluna
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: titleColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(titleIcon, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Lista de Cards
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = items[index];
            
            // Lógica para verificar se este item específico já foi conectado
            bool isConnected = isMaterialColumn 
                ? connections.containsKey(item)
                : connections.containsValue(item);

            return AssociationItemCard(
              text: item,
              isSelected: selectedItem == item,
              isConnected: isConnected,
              isMaterialColumn: isMaterialColumn,
              onTap: () => onItemTap(item),
            );
          },
        ),
      ],
    );
  }
}