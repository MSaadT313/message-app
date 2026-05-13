import 'package:flutter/material.dart';
import 'package:message_app_flutter/global_variables.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isCurrentUser
        ? Colors.white
        : Theme.of(context).colorScheme.inversePrimary;

    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(chatBubbleRadius),
          topRight: Radius.circular(chatBubbleRadius),
          bottomLeft: Radius.circular(isCurrentUser ? chatBubbleRadius : 4),
          bottomRight: Radius.circular(isCurrentUser ? 4 : chatBubbleRadius),
        ),
        boxShadow: showShadows ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: shadowOpacity),
            blurRadius: shadowBlurRadius / 2,
            offset: shadowOffset,
          ),
        ] : [],
      ),
      padding: EdgeInsets.symmetric(horizontal: chatBubblePaddingHorizontal, vertical: chatBubblePaddingVertical),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: Text(
        message,
        style: TextStyle(color: textColor, fontSize: fontSizeBody),
      ),
    );
  }
}
