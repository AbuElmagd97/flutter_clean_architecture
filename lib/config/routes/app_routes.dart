import 'package:flutter/material.dart';
import 'package:flutter_clean_archeticture/core/utils/app_strings.dart';
import 'package:flutter_clean_archeticture/features/favourite_quote/presentation/screens/favourite_quote_screen.dart';
import 'package:flutter_clean_archeticture/features/random_quote/presentation/screens/quote_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String favouriteQuoteRoute = '/favouriteQuote';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const QuoteScreen(),
        );
      case Routes.favouriteQuoteRoute:
        return MaterialPageRoute(
          builder: (context) => const FavouriteQuoteScreen(),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
