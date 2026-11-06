# UniLoop — Your University, Your Loop

UniLoop is a dark-themed Flutter university super-app connecting students,
clubs, professors, alumni, industry clients, and administrators.

## Run locally

```bash
flutter pub get
flutter analyze
flutter run
```

The current MVP is frontend-only and uses local dummy data through
`lib/core/data/mock_store.dart`.

## Demo credentials

Any non-empty email/password works. Seeded demo password: `demo123`.

| Role | Email |
| --- | --- |
| Student | student@loop.edu |
| Club | club@loop.edu |
| Professor | prof@loop.edu |
| Alumni | alumni@loop.edu |
| Admin | admin@loop.edu |
| Industry | industry@company.com |

## Demo journey

Industry posts a project → Student applies → Industry shortlists/accepts →
Student creates workspace tasks → milestone submission → feedback/history.

## Limitations

Backend persistence, real uploads, maps, payments, and production
authentication are intentionally mocked.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
