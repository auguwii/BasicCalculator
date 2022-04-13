import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons(
      {Key? key,
      this.color,
      this.textColor,
      required this.buttonText,
      this.onTap})
      : super(key: key);

  final color;
  final textColor;
  final onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                    color: textColor,
                    //fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
