import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String date;
  final String location;
  final String coverCharge;
  final String imageUrl;
  final List<String> tags;
  final bool isHorizontal;
  final VoidCallback? onTap;

  const EventCard({
    Key? key,
    required this.title,
    this.subtitle,
    required this.date,
    required this.location,
    required this.coverCharge,
    required this.imageUrl,
    required this.tags,
    this.isHorizontal = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return _buildHorizontalCard();
    } else {
      return _buildVerticalCard();
    }
  }

  Widget _buildHorizontalCard() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageHeader(isHorizontal: true),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  _buildEventDetails(),
                  const SizedBox(height: 4),
                  _buildCardFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalCard() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImageHeader(isHorizontal: false),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  _buildEventDetails(),
                  const SizedBox(height: 10),
                  _buildCardFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageHeader({bool isHorizontal = false}) {
    return Stack(
      children: [
        Container(
          height: isHorizontal ? 140 : 180,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2),
                BlendMode.darken,
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tags.take(2).map((tag) => _buildTag(tag)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String tag) {
    Color tagColor;
    if (tag.toUpperCase().contains('HOUSE')) {
      tagColor = const Color(0xFF6958CA);
    } else if (tag.toUpperCase().contains('AGE')) {
      tagColor = const Color(0xFFFF6B6B);
    } else if (tag.toUpperCase().contains('MUSIC')) {
      tagColor = const Color(0xFF4ECDC4);
    } else if (tag.toUpperCase().contains('FESTIVAL')) {
      tagColor = const Color(0xFF95E1D3);
    } else if (tag.toUpperCase().contains('JAZZ')) {
      tagColor = const Color(0xFFFFB347);
    } else if (tag.toUpperCase().contains('NEW')) {
      tagColor = const Color(0xFFFFB347);
    } else {
      tagColor = const Color(0xFF6958CA);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        tag.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildEventDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[500]),
            const SizedBox(width: 6),
            Text(
              date,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.location_on_outlined, size: 14, color: Colors.grey[500]),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                location,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildAttendeeAvatars(),
            const SizedBox(width: 8),
            Text(
              '+42',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF6958CA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'View Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttendeeAvatars() {
    return SizedBox(
      width: 60,
      height: 24,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.blue[300],
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1A1A1A), width: 2),
              ),
            ),
          ),
          Positioned(
            left: 18,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.pink[300],
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1A1A1A), width: 2),
              ),
            ),
          ),
          Positioned(
            left: 36,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.green[300],
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1A1A1A), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
