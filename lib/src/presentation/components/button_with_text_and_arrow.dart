import 'package:flutter/material.dart';

class ButtonWithTextAndArrow extends StatelessWidget {
  const ButtonWithTextAndArrow({
    Key? key,
    this.text,
    this.icon,
    this.buttonColor,
    this.textAndArrowColor,
    required this.onTap,
  }) : super(key: key);

  final String? text;
  final IconData? icon;
  final Color? buttonColor, textAndArrowColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Color _buttonColor = buttonColor ?? Colors.blue,
        _textAndArrowColor = textAndArrowColor ?? Colors.white;

    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: _buttonColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            child: Row(
              children: [
                Text(
                  text ?? "Button",
                  style: TextStyle(
                    color: _textAndArrowColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.04,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(icon ?? Icons.arrow_forward_rounded,
                    color: _textAndArrowColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
