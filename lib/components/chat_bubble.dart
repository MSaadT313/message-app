import 'package:flutter/material.dart';
import 'package:message_app_flutter/global_variables.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String? timestamp;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Sent bubble: indigo gradient; Received: card color
    final bubbleColor = isCurrentUser
        ? null // gradient handled below
        : Theme.of(context).colorScheme.secondary;

    final textColor = isCurrentUser
        ? Colors.white
        : Theme.of(context).colorScheme.inversePrimary;

    final timeColor = isCurrentUser
        ? Colors.white.withValues(alpha: 0.65)
        : Theme.of(context).colorScheme.tertiary;

    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        gradient: isCurrentUser
            ? LinearGradient(
          colors: isDark
              ? [const Color(0xFF6366F1), const Color(0xFF4F46E5)]
              : [const Color(0xFF4F46E5), const Color(0xFF4338CA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : null,
        color: bubbleColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(chatBubbleRadius),
          topRight: Radius.circular(chatBubbleRadius),
          bottomLeft: Radius.circular(isCurrentUser ? chatBubbleRadius : 4),
          bottomRight: Radius.circular(isCurrentUser ? 4 : chatBubbleRadius),
        ),
        boxShadow: showShadows
            ? [
          BoxShadow(
            color: isCurrentUser
                ? const Color(0xFF6366F1).withValues(alpha: 0.22)
                : Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ]
            : [],
        border: !isCurrentUser
            ? Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 0.8,
        )
            : null,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: chatBubblePaddingHorizontal,
        vertical: chatBubblePaddingVertical,
      ),
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message,
            style: TextStyle(
              color: textColor,
              fontSize: fontSizeBody,
              height: 1.4,
            ),
          ),
          if (timestamp != null) ...[
            const SizedBox(height: 4),
            Text(
              timestamp!,
              style: TextStyle(
                color: timeColor,
                fontSize: fontSizeCaption,
              ),
            ),
          ],
        ],
      ),
    );
  }
}