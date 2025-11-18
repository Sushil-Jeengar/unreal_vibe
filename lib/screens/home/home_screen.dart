import 'package:flutter/material.dart';
import 'package:unreal_vibe/screens/home/widgets/event_card.dart';
import 'package:unreal_vibe/screens/home/widgets/search_bar.dart';
import '../../models/event_model.dart';

import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Event> events = Event.getMockEvents();
  final List<String> filterTags = ['All', 'Music', 'Festival']; // Updated filters
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final trendingEvents = events.where((event) => event.isTrending).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(),
              const SizedBox(height: 24),
              const CustomSearchBar(),
              const SizedBox(height: 32),
              _buildTrendingEvents(trendingEvents),
              const SizedBox(height: 32),
              _buildAllEvents(),
              const SizedBox(height: 100), // Space for bottom navigation
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Unrealvibes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                'Noida',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            children: [
              const TextSpan(
                text: 'FIND YOUR ',
                style: TextStyle(color: Colors.white),
              ),
              const TextSpan(
                text: 'VIBE.\n',
                style: TextStyle(
                  color: Color(0xFFFFD700), // Yellow
                ),
              ),
              const TextSpan(
                text: 'LIVE THE ',
                style: TextStyle(color: Colors.white),
              ),
              const TextSpan(
                text: 'MUSIC.',
                style: TextStyle(
                  color: Color(0xFF6958CA), // Purple
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Discover unforgettable events and create your own.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingEvents(List<Event> events) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Trending Events',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'See all',
                style: TextStyle(
                  color: Color(0xFF6958CA),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Container(
                width: 260,
                margin: const EdgeInsets.only(
                  right: 16,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: EventCard(
                  title: event.title,
                  subtitle: event.subtitle,
                  date: event.date,
                  location: event.location,
                  coverCharge: event.coverCharge,
                  imageUrl: event.imageUrl,
                  tags: event.tags,
                  isHorizontal: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAllEvents() {
    final filteredEvents = selectedFilter == 'All'
        ? events
        : events.where((event) => event.tags.any((tag) =>
            tag.toLowerCase().contains(selectedFilter.toLowerCase()))).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All Events',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filterTags.length,
            itemBuilder: (context, index) {
              final tag = filterTags[index];
              final isSelected = selectedFilter == tag;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFilter = tag;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF6958CA) : const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected ? null : Border.all(color: const Color(0xFF3A3A3A)),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[400],
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredEvents.length,
          itemBuilder: (context, index) {
            final event = filteredEvents[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: EventCard(
                title: event.title,
                subtitle: event.subtitle,
                date: event.date,
                location: event.location,
                coverCharge: event.coverCharge,
                imageUrl: event.imageUrl,
                tags: event.tags,
                isHorizontal: false,
              ),
            );
          },
        ),
      ],
    );
  }
}
