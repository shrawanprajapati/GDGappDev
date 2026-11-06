# Architecture Decisions

- Keep the existing feature-based screens and routes; add functionality in place.
- Use MockStore as a ChangeNotifier singleton so future screens can share state.
- Use shared_preferences only for session metadata in this frontend MVP.
- Keep backend, networking, uploads, maps, and production authentication out of scope.
