import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/features/login/presentation/pages/login_page.dart';
import 'package:weather_app/features/search/presentation/pages/search_page.dart';
import 'package:weather_app/features/search/presentation/widget/new_weather_page.dart';
import 'package:weather_app/features/weather/presentation/pages/home_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const WeatherPage(),
    ),
      GoRoute(
    name: 'weather',
    path: '/weather',
    builder: (context, state) {
    // Access query parameters
      final queryParameters = state.uri.queryParameters;
      print(queryParameters['location']); // Check if query parameters are printed correctly
      return NewWeatherPage(
      location: queryParameters['location'] ?? 'Unknown City',
    );
  },
),

    GoRoute(
    name: 'search',
    path: '/search',
    builder: (context, state) {
    // Access query parameters
    final queryParameters = state.uri.queryParameters;
    print(queryParameters["city"]); // Check if query parameters are printed correctly
    return SearchPage(
      city: queryParameters['city'] ?? 'Unknown City',
      condition: queryParameters['condition'] ?? 'Unknown Condition',
      degree: queryParameters['degree'] ?? 'Unknown Degree',
      image: queryParameters['image'] ?? '',
    );
  },
),

  ],
  redirect: (context, state) {
    User? user = FirebaseAuth.instance.currentUser;

    // Determine initial route based on authentication status
    if (user != null) {
      if (state.fullPath == '/') {
        return '/';
      } else {
        return '${state.fullPath}';
      }
    } else {
      return '/login';
    }
  },
);
