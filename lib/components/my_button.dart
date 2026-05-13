import 'package:flutter/material.dart';
import 'package:message_app_flutter/global_variables.dart';

class MyButton extends StatefulWidget {
  final void Function()? onTap;
  final String text;

  const MyButton({super.key, required this.text, required this.onTap});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
        duration: Duration(milliseconds: animationDurationFast),
        curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(buttonBorderRadius),
            boxShadow: showShadows ? [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: _hovered ? 0.4 : 0.2),
                blurRadius: _hovered ? shadowBlurRadius * 2 : shadowBlurRadius,
                offset: _hovered ? const Offset(0, 6) : shadowOffset,
              )
            ] : [],
          ),
          padding: EdgeInsets.all(buttonPadding),
          margin: EdgeInsets.symmetric(horizontal: buttonMarginHorizontal),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: fontWeightBold,
                fontSize: fontSizeBody,
              ),
            ),
          ),
        ),
      ),
    );
  }
}