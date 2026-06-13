import 'package:flutter/material.dart';

class QuizOptions extends StatelessWidget {
  final List<Map<String, String>> alternatives;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  const QuizOptions({
    super.key,
    required this.alternatives,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Se a tela for maior que 600px, renderiza em Grid (2 colunas)
    final bool isWide = screenWidth > 600;

    if (isWide) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: alternatives.length,
        itemBuilder: (context, index) => _buildOptionButton(alternatives[index]),
      );
    }

    // Caso contrário, lista vertical padrão (Mobile)
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: alternatives.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _buildOptionButton(alternatives[index]),
    );
  }

  Widget _buildOptionButton(Map<String, String> alt) {
    final bool isSelected = selectedId == alt["id"];

    return OutlinedButton(
      onPressed: () => onSelected(alt["id"]!),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        side: BorderSide(
          color: isSelected ? Colors.blue : const Color(0xFFE2E8F0),
          width: isSelected ? 2 : 1,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: isSelected ? Colors.blue.withOpacity(0.02) : Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.blue : const Color(0xFFCBD5E1),
                width: 2,
              ),
            ),
            child: isSelected
                ?  Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            '${alt["id"]}) ${alt["text"]}',
            style: const TextStyle(
              color: Color(0xFF334155),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}