import 'package:flutter/material.dart';
import 'package:message_app_flutter/global_variables.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final String? subtitle;
  final int? unreadCount;

  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
    this.subtitle,
    this.unreadCount,
  });

  String _initials(String email) {
    final parts = email.split('@').first.split('.');
    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return email.substring(0, email.length >= 2 ? 2 : 1).toUpperCase();
  }

  Color _avatarColor(String email) {
    final colors = [
      const Color(0xFF6366F1),
      const Color(0xFF8B5CF6),
      const Color(0xFF06B6D4),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFFEF4444),
      const Color(0xFFEC4899),
      const Color(0xFF3B82F6),
    ];
    return colors[email.hashCode.abs() % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final initials = _initials(text);
    final avatarColor = _avatarColor(text);
    final cardColor = Theme.of(context).colorScheme.secondary;
    final borderColor = Theme.of(context).colorScheme.outline;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: userTileMarginVertical,
        horizontal: userTileMarginHorizontal,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(userTileRadius),
          splashColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
          highlightColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.04),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: userTilePaddingVertical,
              horizontal: userTilePaddingHorizontal,
            ),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(userTileRadius),
              border: Border.all(color: borderColor, width: 0.8),
              boxShadow: showShadows && !isDark
                  ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ]
                  : [],
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: userAvatarSize,
                  height: userAvatarSize,
                  decoration: BoxDecoration(
                    color: avatarColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(avatarBorderRadius),
                    border: Border.all(
                      color: avatarColor.withValues(alpha: 0.35),
                      width: 1.2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    initials,
                    style: TextStyle(
                      color: avatarColor,
                      fontWeight: fontWeightBold,
                      fontSize: fontSizeSmall,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Text info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontWeight: fontWeightSemiBold,
                          fontSize: fontSizeBody,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: fontSizeSmall,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                // Unread badge
                if (unreadCount != null && unreadCount! > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      unreadCount! > 99 ? '99+' : '$unreadCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                else
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}