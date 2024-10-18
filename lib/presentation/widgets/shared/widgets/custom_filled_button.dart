import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;
  final TextStyle? textStyle; // Nuevo parámetro para el estilo del texto

  const CustomFilledButton({
    super.key, 
    this.onPressed, 
    required this.text, 
    this.buttonColor,
    this.textStyle, // Agregamos el nuevo parámetro en el constructor
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);

    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: radius,
            bottomRight: radius,
            topLeft: radius,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle ?? const TextStyle(color: Colors.white), // Aplica el textStyle o un estilo predeterminado
      ),
    );
  }
}
