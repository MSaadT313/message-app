import 'package:flutter/material.dart';
import 'package:message_app_flutter/global_variables.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;

  const MyTextfield({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.focusNode,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: buttonMarginHorizontal),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: fontSizeBody),
        ),
      ),
    );
  }
}