class Event {
  final String id;
  final String title;
  final String? subtitle;
  final String date;
  final String location;
  final String coverCharge;
  final String imageUrl;
  final List<String> tags;
  final bool isTrending;
  final String? djName;
  final String? djImage;
  final double? rating;
  final int? ratingCount;
  final String? time;
  final String? ageRestriction;
  final String? dressCode;
  final String? entryFee;
  final List<String>? galleryImages;
  final String? aboutParty;
  final String? partyFlow;
  final String? thingsToKnow;
  final String? partyEtiquette;
  final String? whatsIncluded;
  final String? houseRules;
  final String? howItWorks;
  final String? cancellationPolicy;
  final int? partiesHosted;
  final String? hostName;

  Event({
    required this.id,
    required this.title,
    this.subtitle,
    required this.date,
    required this.location,
    required this.coverCharge,
    required this.imageUrl,
    required this.tags,
    this.isTrending = false,
    this.djName,
    this.djImage,
    this.rating,
    this.ratingCount,
    this.time,
    this.ageRestriction,
    this.dressCode,
    this.entryFee,
    this.galleryImages,
    this.aboutParty,
    this.partyFlow,
    this.thingsToKnow,
    this.partyEtiquette,
    this.whatsIncluded,
    this.houseRules,
    this.howItWorks,
    this.cancellationPolicy,
    this.partiesHosted,
    this.hostName,
  });

  static List<Event> getMockEvents() {
    return [
      Event(
        id: '1',
        title: 'Tales From The Shadows - A Halloween Story Night',
        subtitle: 'Spooky tales and mysterious stories',
        date: 'Oct 31, 2024',
        location: 'Gurgaon, Mumbai',
        coverCharge: '₹ 599',
        imageUrl: 'https://picsum.photos/seed/halloween/400/300',
        tags: ['HOUSE PARTY', 'AGE: 22+'],
        isTrending: true,
      ),
      Event(
        id: '2',
        title: 'Gala Music Festival',
        subtitle: 'An evening of smooth jazz',
        date: 'Nov 15, 2024',
        location: 'Unity Square, ID',
        coverCharge: '₹ 1299',
        imageUrl: 'https://picsum.photos/seed/gala/400/300',
        tags: ['JAZZ', 'NEW'],
        isTrending: true,
      ),
      Event(
        id: '3',
        title: 'Woman\'s Day Festival',
        subtitle: 'Celebrating womanhood',
        date: 'Mar 8, 2024',
        location: 'City Road, ID',
        coverCharge: '₹ 799',
        imageUrl: 'https://picsum.photos/seed/women/400/300',
        tags: ['FESTIVAL', 'WOMEN ONLY'],
      ),
      Event(
        id: '4',
        title: 'Bastau Music Festival',
        subtitle: 'Electronic music extravaganza',
        date: 'Dec 20, 2024',
        location: 'Crowd Avenue, ID',
        coverCharge: '₹ 999',
        imageUrl: 'https://picsum.photos/seed/bastau/400/300',
        tags: ['MUSIC', 'AGE 18+'],
        isTrending: true,
      ),
      Event(
        id: '5',
        title: 'Summer Beats Festival',
        subtitle: 'Dance to the rhythm',
        date: 'Jun 21, 2024',
        location: 'Beach Side, ID',
        coverCharge: '₹ 1499',
        imageUrl: 'https://picsum.photos/seed/summer/400/300',
        tags: ['FESTIVAL', 'DANCE'],
      ),
      Event(
        id: '6',
        title: 'Acoustic Night',
        subtitle: 'Intimate musical performances',
        date: 'Jan 10, 2024',
        location: 'Downtown Cafe, ID',
        coverCharge: '₹ 399',
        imageUrl: 'https://picsum.photos/seed/acoustic/400/300',
        tags: ['MUSIC', 'ACOUSTIC'],
      ),
    ];
  }
}
