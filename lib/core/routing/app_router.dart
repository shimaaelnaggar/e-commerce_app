import 'package:ecommerce_app/core/routing/routes.dart';
import 'package:ecommerce_app/features/auth/views/auth_view.dart';
import 'package:ecommerce_app/features/home/views/home_view.dart';
import 'package:ecommerce_app/features/onboarding/views/country_selector_view.dart';
import 'package:ecommerce_app/features/splash/views/splash_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const CountryView());
      case Routes.auth:
        return MaterialPageRoute(builder: (_) => const AuthView());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No route defined for ${settings.name}")),
          ),
        );
    }
  }
}
