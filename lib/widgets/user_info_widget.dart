import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

/// A reusable widget to display user information anywhere in the app
class UserInfoWidget extends StatelessWidget {
  final bool showFullInfo;
  final TextStyle? nameStyle;
  final TextStyle? emailStyle;

  const UserInfoWidget({
    Key? key,
    this.showFullInfo = true,
    this.nameStyle,
    this.emailStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;

        if (user == null) {
          return const Text(
            'Guest User',
            style: TextStyle(color: Colors.white70),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user.name,
              style: nameStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            if (showFullInfo) ...[
              const SizedBox(height: 4),
              Text(
                user.email,
                style: emailStyle ??
                    const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
              ),
            ],
          ],
        );
      },
    );
  }
}

/// A widget to display user avatar with initials
class UserAvatarWidget extends StatelessWidget {
  final double size;

  const UserAvatarWidget({
    Key? key,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;
        final userName = user?.name ?? 'Guest';

        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            ),
          ),
          child: Center(
            child: Text(
              _getInitials(userName),
              style: TextStyle(
                fontSize: size * 0.4,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }
}
