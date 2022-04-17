import 'package:flutter/material.dart';

class ButtonWithTextAndArrow extends StatelessWidget {
  const ButtonWithTextAndArrow({
    Key? key,
    this.text,
    this.icon,
    this.buttonColor,
    this.textAndArrowColor,
    this.onTap,
    this.isActive = true,
  }) : super(key: key);

  final String? text;
  final IconData? icon;
  final Color? buttonColor, textAndArrowColor;
  final Function? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    Color _buttonColor = buttonColor ?? Colors.blue,
        _textAndArrowColor = textAndArrowColor ?? Colors.white;

    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: isActive ? _buttonColor : _buttonColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap!(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            child: Row(
              children: [
                Text(
                  text ?? "Button",
                  style: TextStyle(
                    color: isActive
                        ? _textAndArrowColor
                        : _textAndArrowColor.withOpacity(0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.04,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  icon ?? Icons.arrow_forward_rounded,
                  color: isActive
                      ? _textAndArrowColor
                      : _textAndArrowColor.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
