import 'package:flutter/material.dart';

class UniversalBackButton extends StatelessWidget {
  final String label;
  final bool iconMode;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;

  const UniversalBackButton({
    Key? key,
    this.label = 'Voltar',
    this.iconMode = false,
    this.iconColor,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.onPressed,
  }) : super(key: key);

  void _handlePress(BuildContext context) {
    if (onPressed != null) {
      onPressed!();
      return;
    }
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (iconMode) {
      return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: iconColor ?? foregroundColor ?? Colors.black,
        ),
        style: IconButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding ?? const EdgeInsets.all(12),
          foregroundColor: foregroundColor,
        ),
        onPressed: () => _handlePress(context),
      );
    }

    return ElevatedButton.icon(
      onPressed: () => _handlePress(context),
      icon: Icon(
        Icons.arrow_back,
        color: iconColor ?? foregroundColor ?? Colors.black,
      ),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.white,
        foregroundColor: foregroundColor ?? const Color(0xFF24324B),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
