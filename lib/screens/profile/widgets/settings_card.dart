import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Column(
        children: [
          _buildSettingsItem(Icons.edit, 'Edit Profile', () {}),
          _buildDivider(),
          _buildSettingsItem(Icons.lock, 'Privacy', () {}),
          _buildDivider(),
          _buildSettingsItem(Icons.notifications, 'Notifications', () {}),
          _buildDivider(),
          _buildSettingsItem(Icons.lock_clock, 'Change Password', () {}),
          _buildDivider(),
          _buildSettingsItem(Icons.logout, 'Logout', () {}, isDestructive: true),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : const Color(0xFF6366F1),
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isDestructive ? Colors.red : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isDestructive ? Colors.red.withOpacity(0.5) : const Color(0xFF9CA3AF),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: const Color(0xFF2A2A2A),
      margin: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
