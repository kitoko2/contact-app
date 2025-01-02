import 'package:contact_app/core/router.dart';
import 'package:contact_app/core/theme/app_theme.dart';
import 'package:contact_app/presentation/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      title: appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      builder: (context, child) {
        // Pour limiter l'échelle du texte en fonction de l'accessibilité de l'utilisateur
        // On lit les paramètres de MediaQuery actuels
        final mediaQuery = MediaQuery.of(context);
        // Création du nouveau MediaQuery avec les paramètres contrôlés
        return MediaQuery(
          data: mediaQuery.copyWith(
            // Limiter l'échelle du texte
            textScaler: mediaQuery.textScaler
                .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.25),
          ),
          child: child!,
        );
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
