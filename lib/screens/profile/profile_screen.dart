import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/responsive_helper.dart';
import '../../providers/user_provider.dart';
import 'widgets/profile_header.dart';
import 'widgets/host_mode_toggle.dart';
import 'widgets/verification_card.dart';
import 'widgets/my_profile_card.dart';
import 'widgets/settings_card.dart';
import 'widgets/achievements_card.dart';
import 'widgets/additional_options_card.dart';
import 'widgets/dark_mode_switch.dart';
import 'widgets/footer_links.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveHelper.getResponsivePadding(context, 16.0);
    
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            backgroundColor: const Color(0xFF0A0A0A),
            elevation: 0,
            pinned: true,
            expandedHeight: 20,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0A0A0A), Color(0xFF121212)],
                ),
              ),
            ),
            title: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: ResponsiveHelper.getMaxContentWidth(context),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Unreal Vibe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveHelper.getResponsiveFontSize(context, 20),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) {
                        final userCity = userProvider.user?.city.toUpperCase() ?? 'NOIDA';
                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on, color: Color(0xFF6366F1), size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    userCity,
                                    style: TextStyle(
                                      color: const Color(0xFF9CA3AF),
                                      fontSize: ResponsiveHelper.getResponsiveFontSize(context, 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              icon: const Icon(Icons.settings, color: Color(0xFF9CA3AF)),
                              onPressed: () {},
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Main Content
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: ResponsiveHelper.getMaxContentWidth(context),
                ),
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const ProfileHeader(),
                    const SizedBox(height: 24),
                    const HostModeToggle(),
                    const SizedBox(height: 24),
                    const VerificationCard(),
                    const SizedBox(height: 24),
                    const MyProfileCard(),
                    const SizedBox(height: 24),
                    const SettingsCard(),
                    const SizedBox(height: 24),
                    const AchievementsCard(),
                    const SizedBox(height: 24),
                    const AdditionalOptionsCard(),
                    const SizedBox(height: 24),
                    const DarkModeSwitch(),
                    const SizedBox(height: 32),
                    const FooterLinks(),
                    const SizedBox(height: 20),
                    const Copyright(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
