
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vipul_test_assignment/presentation/screens/home_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _userHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');

const String userGuideScreen = '/userGuideScreen';
const String askLoginTypeScreen = '/askLoginTypeScreen';


final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: userGuideScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),

  ],
);


