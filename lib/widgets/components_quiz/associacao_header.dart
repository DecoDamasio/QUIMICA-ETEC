import 'package:flutter/material.dart';

class AssociationHeader extends StatelessWidget {
  final int points;
  final String time;
  final int connections;
  final int totalConnections;

  const AssociationHeader({
    Key? key,
    required this.points,
    required this.time,
    required this.connections,
    required this.totalConnections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _buildInfoCard(
          icon: Icons.flash_on,
          iconColor: Colors.amber,
          title: 'Pontos',
          value: '$points',
        ),
        _buildInfoCard(
          icon: Icons.access_time_filled,
          iconColor: Colors.blue,
          title: 'Tempo',
          value: time,
        ),
        _buildInfoCard(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          title: 'Conexões',
          value: '$connections/$totalConnections',
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w500),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}