import 'package:flutter/material.dart';

class WhiteOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const WhiteOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.cyan),

        // Borda azul
        side: MaterialStateProperty.all(
          const BorderSide(color: Colors.cyan, width: 2),
        ),

        // Sem mudança de cor no hover
        overlayColor: MaterialStateProperty.all(Colors.transparent),

        // Elevação (efeito de "levantar")
        elevation: MaterialStateProperty.resolveWith<double>(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return 2; // clicado
            }
            return 6; // normal (levitado)
          },
        ),

        shadowColor: MaterialStateProperty.all(Colors.black26),

        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
      child: Text(text),
    );
  }
}