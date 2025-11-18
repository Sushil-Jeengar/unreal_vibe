import 'package:flutter/material.dart';

class MyProfileCard extends StatelessWidget {
  const MyProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildProfileField('Bio/About Me', 'Tell people about yourself...'),
          _buildProfileField('Fun Fact About Me', 'Share something interesting!'),
          const SizedBox(height: 16),
          const Text(
            'Vibe/Interests',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildInterestTag('Music'),
              _buildInterestTag('Travel'),
              _buildInterestTag('Photography'),
              _buildInterestTag('Food'),
              _buildInterestTag('Art'),
            ],
          ),
          const SizedBox(height: 16),
          _buildProfileField('Dream Travel Destination', 'Where do you want to go?'),
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF2A2A2A)),
          ),
          child: Text(
            hint,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInterestTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.3)),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Color(0xFF6366F1),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
