import 'package:flutter/material.dart';

class AcoesBotoes extends StatelessWidget {
  final VoidCallback onVisualizar;
  final VoidCallback onEditar;

  const AcoesBotoes({
    Key? key,
    required this.onVisualizar,
    required this.onEditar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // botao de visu
        IconButton(
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          padding: EdgeInsets.zero,
          onPressed: onVisualizar,
          icon: const Icon(Icons.visibility_outlined, color: Color(0xFF1890FF), size: 18),
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFFE6F7FF),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
        const SizedBox(width: 8),
        
        // botao pra editar
        IconButton(
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          padding: EdgeInsets.zero,
          onPressed: onEditar,
          icon: const Icon(Icons.edit_outlined, color: Colors.black54, size: 18),
          style: IconButton.styleFrom(
            side: const BorderSide(color: Color(0xFFD9D9D9)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
      ],
    );
  }
}