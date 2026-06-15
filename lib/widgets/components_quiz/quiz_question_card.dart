import 'package:flutter/material.dart';

class QuizQuestionCard extends StatelessWidget {
  final String assetPath;

  const QuizQuestionCard({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFCBD5E1),
          style: BorderStyle.solid, // Nota: Para tracejado real puro usa-se o package 'dotted_border'
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              )
            ],
          ),
          
          child: Image.asset(
                    assetPath,
                    width: 250,
                    height: 180,
                    fit: BoxFit.contain,
                  )
          ),
        ),
      );
  }
}