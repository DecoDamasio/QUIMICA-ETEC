import 'package:flutter/material.dart';

class InfoGrid extends StatelessWidget {
  const InfoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Informações Adicionais", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 40,
            runSpacing: 16,
            children: [
              _InfoItem(label: "ID da Questão", value: "Nível 1 - Q01"),
              _InfoItem(label: "Tipo", value: "Quiz (Identificação)"),
              _InfoItem(label: "Criado em", value: "12/01/2025"),
              _InfoItem(label: "Última edição", value: "14/01/2025"),
              _InfoItem(label: "Respondida por", value: "45 alunos"),
              _InfoItem(label: "Taxa de acerto", value: "73%"),
            ],
          )
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label, value;
  const _InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class ActionFooter extends StatelessWidget {
  const ActionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.save),
          label: const Text("Salvar Alterações"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7C3AED), // Roxo
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(width: 16),
        TextButton(
          onPressed: () {},
          child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}