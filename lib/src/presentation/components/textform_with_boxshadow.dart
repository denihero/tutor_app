import 'package:flutter/material.dart';

class TextFormWithBoxShadow extends StatefulWidget {
  const TextFormWithBoxShadow({
    Key? key,
    this.textEditingController,
    this.hintText,
    required this.focusNode,
    required this.icon,
    this.isPasswordField = false,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final FocusNode focusNode;
  final String? hintText;
  final IconData icon;
  final bool isPasswordField;

  @override
  State<TextFormWithBoxShadow> createState() => _TextFormWithBoxShadowState();
}

class _TextFormWithBoxShadowState extends State<TextFormWithBoxShadow> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: widget.focusNode.hasFocus
                ? Colors.black.withOpacity(0.3)
                : Colors.transparent,
            offset: Offset(0, 1),
            blurRadius: 5,
          )
        ],
      ),
      child: TextField(
        controller: widget.textEditingController,
        obscureText: widget.isPasswordField,
        focusNode: widget.focusNode,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: Colors.black.withOpacity(0.3),
          ),
          focusedBorder: InputBorder.none,
          labelText: widget.hintText ?? "Text Form",
          labelStyle: TextStyle(
            color: widget.focusNode.hasFocus
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.3),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.03,
          ),
        ),
      ),
    );
  }
}
