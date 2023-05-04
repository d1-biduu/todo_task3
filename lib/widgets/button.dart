import 'package:flutter/material.dart';
class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
 final  Color color;
  const Button( {super.key, required this.text, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color:color,
      child: Text(text, style: const TextStyle(color: Colors.white),),
    );
  }
}