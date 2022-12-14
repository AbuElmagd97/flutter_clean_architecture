import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_archeticture/config/routes/app_routes.dart';
import 'config/locale/app_localizations_setup.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'features/splash/presentation/cubit/locale_cubit.dart';
import 'injection_container.dart' as di;

class QuoteApp extends StatelessWidget {
  const QuoteApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<LocaleCubit>()..getSavedLang()),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          buildWhen: (previousState, currentState) {
            return previousState != currentState;
          },
          builder: (context, state) {
            return MaterialApp(
              title: AppStrings.appName,
              locale: state.locale,
              debugShowCheckedModeBanner: false,
              theme: appTheme(),
              onGenerateRoute: AppRoutes.onGenerateRoute,
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localeResolutionCallback:
              AppLocalizationsSetup.localeResolutionCallback,
              localizationsDelegates:
              AppLocalizationsSetup.localizationsDelegates,
            );
          },
        ));
  }
}
