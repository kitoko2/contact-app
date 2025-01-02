import 'package:contact_app/domain/entities/contact_entity.dart';
import 'package:contact_app/presentation/home/blocs/contact_bloc.dart';
import 'package:contact_app/presentation/home/pages/details_contact_page.dart';
import 'package:contact_app/presentation/home/pages/home_page.dart';
import 'package:contact_app/presentation/onboarding/blocs/onboarding_bloc.dart';
import 'package:contact_app/presentation/onboarding/pages/onboarding_page.dart';
import 'package:contact_app/presentation/shared/utils.dart';
import 'package:contact_app/presentation/splash/blocs/splash_bloc.dart';
import 'package:contact_app/presentation/splash/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final GetIt getIt = GetIt.instance;

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Définir les routes de l'application
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      // Splash
      GoRoute(
        path: '/',
        name: SplashPage.routeName,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SplashBloc>()..add(CheckOnboardingStatusEvent()),
          child: const SplashPage(),
        ),
      ),
      // Onboarding
      GoRoute(
        path: '/${OnboardingPage.routeName}',
        name: OnboardingPage.routeName,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<OnboardingBloc>(),
          child: const OnboardingPage(),
        ),
      ),
      // Main page
      GoRoute(
        path: '/${HomePage.routeName}',
        name: HomePage.routeName,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<ContactBloc>()
            ..add(LoadContactsEvent(
                context: context, results: contactsPerPage, page: initialPage)),
          child: const HomePage(),
        ),
        routes: [
          GoRoute(
            path: DetailsContactPage.routeName,
            name: DetailsContactPage.routeName,
            builder: (context, state) {
              final Map<String, dynamic> extra =
                  state.extra! as Map<String, dynamic>;
              final contact = extra['contatct'] as ContactEntity;
              return DetailsContactPage(contact: contact);
            },
          ),
        ],
      ),
    ],
  );
}
