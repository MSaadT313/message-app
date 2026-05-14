import 'package:flutter/material.dart';
import 'package:message_app_flutter/global_variables.dart';

class MyTextfield extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final String? errorText;

  const MyTextfield({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.focusNode,
    this.onSubmitted,
    this.prefixIcon,
    this.keyboardType,
    this.errorText,
  });

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final tertiary = Theme.of(context).colorScheme.tertiary;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: buttonMarginHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            obscureText: widget.obscureText && !_showPassword,
            controller: widget.controller,
            focusNode: widget.focusNode,
            onSubmitted: widget.onSubmitted,
            keyboardType: widget.keyboardType,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: fontSizeBody,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(widget.prefixIcon, color: tertiary, size: 20)
                  : null,
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                onTap: () =>
                    setState(() => _showPassword = !_showPassword),
                child: Icon(
                  _showPassword
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: tertiary,
                  size: 20,
                ),
              )
                  : null,
              errorText: widget.errorText,
              errorStyle: const TextStyle(
                color: Color(0xFFEF4444),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}