import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project1/features/home/presentation/views/home_page.dart';
import '../../features/authentication/presentation/views/login_screen.dart';
import '../../features/authentication/presentation/views/register_screen.dart';
import '../../features/onBoarding/presentation/view/screens/onboarding_view.dart';
import '../../features/profile/presentation/views/edit_account_view.dart';

abstract class AppRoutes {
  static const String editAccountView = '/EditAccountView';
  static const String homeView = '/homeView';
  static const String searchView = '/SearchView';
  static const String onboardingView = '/';
  static const String loginView = '/loginView';
  static const String registerView = '/RegisterView';
  static const String checkEmail = '/checkEmail';

  static final router = GoRouter(
    routes: <RouteBase>[
      /*GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),*/
      GoRoute(
        path: homeView,
        builder: (BuildContext context, GoRouterState state) {
          return const BottomNavBarPage();
        },
      ),
      GoRoute(
        path: onboardingView,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingView();
        },
      ),
      GoRoute(
        path: loginView,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: registerView,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: editAccountView,
        builder: (BuildContext context, GoRouterState state) {
          return const EditAccountView();
        },
      ),
    ],
  );
}
