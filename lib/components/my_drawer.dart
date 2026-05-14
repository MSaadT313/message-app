import 'package:flutter/material.dart';
import 'package:message_app_flutter/global_variables.dart';
import 'package:message_app_flutter/Services/authentication/auth_service.dart';
import 'package:message_app_flutter/pages/friends_page.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  String _initials(String? email) {
    if (email == null || email.isEmpty) return '?';
    final parts = email.split('@').first.split('.');
    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return email.substring(0, email.length >= 2 ? 2 : 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final surface = Theme.of(context).colorScheme.surface;
    final onSurface = Theme.of(context).colorScheme.inversePrimary;
    final tertiary = Theme.of(context).colorScheme.tertiary;
    final outline = Theme.of(context).colorScheme.outline;

    final authService = AuthService();
    final userEmail = authService.getCurrentUser()?.email ?? '';
    final initials = _initials(userEmail);

    return Drawer(
      backgroundColor: isDark ? const Color(0xFF0D1120) : const Color(0xFFFAFBFF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: outline, width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primary,
                          primary.withValues(alpha: 0.75),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    userEmail.split('@').first,
                    style: TextStyle(
                      color: onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    userEmail,
                    style: TextStyle(
                      color: tertiary,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ── Nav Items ────────────────────────────
            _NavItem(
              icon: Icons.home_rounded,
              label: 'واپسی',
              onTap: () => Navigator.pop(context),
            ),
            _NavItem(
              icon: Icons.people_rounded,
              label: 'دوست',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FriendsPage()),
                );
              },
            ),
            _NavItem(
              icon: Icons.settings_rounded,
              label: 'تبدیلی',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),

            const Spacer(),

            // ── Divider + Logout ─────────────────────
            Divider(color: outline, height: 1),
            _NavItem(
              icon: Icons.logout_rounded,
              label: 'لاگ آؤٹ',
              onTap: logout,
              isDestructive: true,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final onSurface = Theme.of(context).colorScheme.inversePrimary;
    final iconColor =
    isDestructive ? const Color(0xFFEF4444) : Theme.of(context).colorScheme.tertiary;
    final textColor =
    isDestructive ? const Color(0xFFEF4444) : onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          splashColor: primary.withValues(alpha: 0.08),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: drawerIconSize),
                const SizedBox(width: 14),
                Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSizeBody,
                    fontWeight: fontWeightMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}