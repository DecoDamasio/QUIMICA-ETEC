import 'package:flutter/material.dart';

class HeaderInfoCard extends StatelessWidget {
  final double width;
  const HeaderInfoCard({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9D5FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.layers_outlined, color: Color(0xFF7C3AED), size: 20),
              SizedBox(width: 8),
              Text('Estrutura de Questões por Nível', style: TextStyle(color: Color(0xFF5B21B6), fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              final content = [
                _buildInfoBadge(Colors.green, '10 Questões de Quiz', 'Identificação de vidrarias e equipamentos'),
                if (isMobile) const SizedBox(height: 12) else const SizedBox(width: 24),
                _buildInfoBadge(const Color(0xFF8B5CF6), '10 Questões de Associação', 'Conectar itens às suas funções'),
              ];
              return isMobile ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: content) : Row(children: content);
            },
          ),
          const SizedBox(height: 8),
          const Text(
            'Total: 20 questões por nível • 4 níveis • 80 questões no jogo completo',
            style: TextStyle(color: Color(0xFF7C3AED), fontSize: 11, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _buildInfoBadge(Color color, String title, String subtitle) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: const EdgeInsets.all(4), width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 13)),
            Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
          ],
        )
      ],
    );
  }
}