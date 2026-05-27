# Unreal Vibe

A Flutter app for discovering and booking events — parties, concerts, and live experiences near you. Built with a dark, immersive UI and a full ticketing + payment flow.

---

## Features

- **Event Discovery** — Browse trending and all events filtered by city, category, date, and price
- **Search** — City-aware search with live suggestions
- **Event Details** — Full event info with host details, ticket tiers, location, reviews, and share
- **Ticket Booking** — Select passes, fill attendee details, and pay via PhonePe
- **My Tickets** — View booked tickets with QR codes and download support
- **Saved Events** — Bookmark events to revisit later
- **Explore** — Discover events beyond your city
- **Create Events** — Host mode for creating and managing your own events
- **Notifications** — Real-time notifications via SSE + REST
- **Profile** — Edit profile, verify identity, upload documents, request host mode
- **Responsive** — Adapts layout for mobile, tablet, and desktop

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x / Dart |
| State Management | Provider |
| HTTP | `http`, `dio` |
| Local Storage | `shared_preferences` |
| Payments | PhonePe Payment Gateway |
| Media | `video_player`, `image_picker` |
| Location | `geolocator`, `permission_handler` |
| Maps | `url_launcher` (Google Maps deep link) |
| QR Codes | `qr_flutter` |
| Sharing | `share_plus` |
| Real-time | SSE (`http`) + WebSocket (`web_socket_channel`) |
| File Downloads | `path_provider`, `flutter_file_dialog` |

---

## Project Structure

```
lib/
├── main.dart                  # App entry point, providers setup
├── models/                    # Data models (Event, User, Ticket, etc.)
├── providers/                 # State management (User, Event, Payment)
├── services/                  # API calls, storage, business logic
├── screens/
│   ├── auth/                  # Splash, OTP login, onboarding
│   ├── home/                  # Home feed, event cards, event details
│   ├── explore/               # Explore screen
│   ├── create/                # Create event flow
│   ├── ticket/                # Ticket selection, payment, QR, my tickets
│   └── profile/               # Profile, notifications, saved events
├── widgets/                   # Shared widgets (hero video, filters, skeletons)
├── navigation/                # Bottom nav + responsive rail navigation
└── utils/                     # Helpers (date formatter, responsive, error handler)
```

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.9.2`
- Dart SDK `^3.9.2`
- Android Studio / Xcode for device targets

### Setup

```bash
# Clone the repo
git clone https://github.com/Sushil-Jeengar/unreal_vibe.git
cd unreal_vibe

# Install dependencies
flutter pub get

# Run on a connected device or emulator
flutter run
```

### Environment Configuration

This project requires a few config files that are excluded from version control for security:

**`lib/config/phonepe_config.dart`** — PhonePe payment credentials:
```dart
class PhonePeConfig {
  static const String merchantId = 'YOUR_MERCHANT_ID';
  static const String saltKey = 'YOUR_SALT_KEY';
  static const String saltIndex = '1';
  static const String apiBaseUrl = 'https://api.unrealvibe.com';
  static const bool isTestMode = true; // false for production
}
```

Create this file locally before running the app.

---

## Build

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## API

The app connects to `https://api.unrealvibe.com/api`. Authentication uses OTP-based login — a phone number receives an OTP, which is verified to return a Bearer token stored locally.

Key endpoint groups:
- `/auth` — OTP request & verify
- `/event` — List, search, filter, save, share, review
- `/passes` — Ticket passes per event, my passes, download
- `/payment` — Create order, verify payment
- `/user` — Profile CRUD, host mode request
- `/notifications` — REST + SSE real-time feed
- `/coupons` — Apply discount codes

---

## Contributing

1. Fork the repo
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m "feat: add your feature"`
4. Push and open a PR

---

## License

Private — All rights reserved © Unreal Vibe
