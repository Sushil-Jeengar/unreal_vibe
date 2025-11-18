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
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageHeader(isHorizontal: true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                ],
                _buildEventDetails(),
                const SizedBox(height: 2),
                _buildCardFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageHeader(isHorizontal: false),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                ],
                _buildEventDetails(),
                const SizedBox(height: 16),
                _buildCardFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHeader({bool isHorizontal = false}) {
    return Stack(
      children: [
        Container(
          height: isHorizontal ? 120 : 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Wrap(
            spacing: 6,
            children: tags.take(2).map((tag) => _buildTag(tag)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String tag) {
    Color tagColor;
    if (tag.toUpperCase().contains('HOUSE')) {
      tagColor = Colors.purple;
    } else if (tag.toUpperCase().contains('AGE')) {
      tagColor = Colors.red;
    } else if (tag.toUpperCase().contains('MUSIC')) {
      tagColor = Colors.blue;
    } else if (tag.toUpperCase().contains('FESTIVAL')) {
      tagColor = Colors.green;
    } else if (tag.toUpperCase().contains('JAZZ')) {
      tagColor = Colors.orange;
    } else {
      tagColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
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
            Icon(Icons.calendar_today, size: 12, color: Colors.grey[400]),
            const SizedBox(width: 3),
            Text(
              date,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.location_on, size: 12, color: Colors.grey[400]),
            const SizedBox(width: 3),
            Expanded(
              child: Text(
                location,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 11,
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
        Text(
          'Cover: $coverCharge',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Book Now',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
