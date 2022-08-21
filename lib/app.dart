import 'package:flutter/material.dart';
import 'package:flutter_clean_archeticture/config/routes/app_routes.dart';
import 'package:flutter_clean_archeticture/features/random_quote/presentation/screens/quote_screen.dart';

import 'config/themes/app_theme.dart';
import 'core/utils/app_strings.dart';

class QuoteApp extends StatelessWidget {
  const QuoteApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: appTheme(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: const QuoteScreen(),
    );
  }
}
