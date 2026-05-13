import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:message_app_flutter/global_variables.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: userTileMarginVertical, horizontal: userTileMarginHorizontal),
      child: ClipPath(
        clipper: _SquircleClipper(radius: userTileRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.18),
                  Colors.white.withValues(alpha: 0.06),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.2),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                splashColor: Colors.white.withValues(alpha: 0.08),
                highlightColor: Colors.white.withValues(alpha: 0.04),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: userTilePaddingVertical, horizontal: userTilePaddingHorizontal),
                  child: Row(
                    children: [
                      ClipPath(
                        clipper: _SquircleClipper(radius: userTileRadius / 1.5),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: userAvatarSize,
                            height: userAvatarSize,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withValues(alpha: 0.22),
                                  Colors.white.withValues(alpha: 0.08),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.25), width: 1),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.person_rounded,
                              color: Colors.white.withValues(alpha: 0.7),
                              size: userAvatarIconSize,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontWeight: fontWeightSemiBold,
                            fontSize: fontSizeBody,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SquircleClipper extends CustomClipper<Path> {
  final double radius;
  _SquircleClipper({required this.radius});

  @override
  Path getClip(Size size) {
    final p = Path();
    final r = radius * 1.6;
    p.moveTo(r, 0);
    p.lineTo(size.width - r, 0);
    p.cubicTo(size.width, 0, size.width, 0, size.width, r);
    p.lineTo(size.width, size.height - r * 1.4);
    p.cubicTo(size.width, size.height, size.width, size.height, size.width - r * 1.4, size.height);
    p.lineTo(r, size.height);
    p.cubicTo(0, size.height, 0, size.height, 0, size.height - r);
    p.lineTo(0, r);
    p.cubicTo(0, 0, 0, 0, r, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(_SquircleClipper old) => old.radius != radius;
}