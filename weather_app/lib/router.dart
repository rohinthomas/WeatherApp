import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/features/login/presentation/pages/login_page.dart';
import 'package:weather_app/features/search/presentation/pages/search_page.dart';
import 'package:weather_app/features/search/presentation/widget/new_weather_page.dart';
import 'package:weather_app/features/weather/presentation/pages/home_page.dart';

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
        final queryParameters = state.uri.queryParameters;
        
        return NewWeatherPage(
          location: queryParameters['location'] ?? 'Unknown City',
        );
      },
    ),
    GoRoute(
      name: 'search',
      path: '/search/:cityname/:conditn/:deg/:img',
      builder: (context, state) {
        return SearchPage(
          city: state.pathParameters['cityname'] ?? 'Unknown City',
          condition: state.pathParameters['conditn'] ?? 'Unknown Condition',
          degree: state.pathParameters['deg'] ?? 'Unknown Degree',
          image: state.pathParameters['img'] ?? '',
        );
      },
    ),
  ],
  redirect: (context, state) {
    User? user = FirebaseAuth.instance.currentUser;

    // Only redirect if the path is not already correct
    if (user == null && state.fullPath != '/login') {
      return '/login';
    } else if (user != null && state.fullPath == '/login') {
      return '/';
    }

    // No redirect needed
    return null;
  },
);
