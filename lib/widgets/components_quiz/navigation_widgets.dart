import 'package:flutter/material.dart';

class LevelSelector extends StatelessWidget {
  final int currentLevel;
  final ValueChanged<int> onLevelChanged;

  const LevelSelector({super.key, required this.currentLevel, required this.onLevelChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade100)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(4, (index) {
            int level = index + 1;
            bool isSelected = currentLevel == level;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text("Nível $level - ${['Iniciante', 'Intermediário', 'Avançado', 'Expert'][index]}"),
                selected: isSelected,
                onSelected: (_) => onLevelChanged(level),
                selectedColor: Colors.blue.shade50,
                labelStyle: TextStyle(color: isSelected ? Colors.blue : Colors.grey),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: isSelected ? Colors.blue : Colors.transparent)),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class QuestionNavigator extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onPrev, onNext;

  const QuestionNavigator({super.key, required this.currentIndex, required this.onPrev, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade100)),
      child: Column(
        children: [
          const Text("Navegação - Nível 1", style: TextStyle(fontSize: 12, color: Colors.grey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(onPressed: onPrev, icon: const Icon(Icons.arrow_back), label: const Text("Anterior")),
              Text("Questão $currentIndex de 20", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
              ElevatedButton.icon(
                onPressed: onNext,
                icon: const Icon(Icons.arrow_forward),
                label: const Text("Próxima"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Bolinhas de progresso
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(20, (index) {
              bool isAssociation = index >= 10;
              Color color = isAssociation ? Colors.purple : Colors.blue;
              return Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: (index + 1) == currentIndex ? color : color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Legend(color: Colors.blue, label: "Quiz (1-10)"),
              SizedBox(width: 16),
              _Legend(color: Colors.purple, label: "Associação (11-20)"),
            ],
          )
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(radius: 4, backgroundColor: color),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 10)),
    ]);
  }
}