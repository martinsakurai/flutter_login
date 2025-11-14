import 'package:flutter_login/screens/add_player_screen.dart';
import 'package:flutter_login/screens/homescreen.dart';
import 'package:flutter_login/screens/loginscreen.dart';
import 'package:flutter_login/screens/view_player_screen.dart';
import 'package:flutter_login/screens/edit_player_screen.dart';
import 'package:flutter_login/screens/registerscreen.dart';
import 'package:flutter_login/entities/users.dart';
import 'package:flutter_login/entities/new_players_provider.dart';
import 'package:flutter_login/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

final routerApp = GoRouter(
  routes: [
    GoRoute(
      name: LoginScreen.name,
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: RegisterScreen.name,
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: HomeScreen.name,
      path: '/home',
      builder: (context, state) =>
          const HomeScreen(),
    ),
    GoRoute(
      name: AddPlayerScreen.name,
      path: '/addPlayer',
      builder: (context, state) => const AddPlayerScreen(),
    ),
    GoRoute(
      name: ViewPlayerScreen.name,
      path: '/viewPlayer',
      builder: (context, state) =>
          ViewPlayerScreen(jugador: state.extra as Player),
    ),
    GoRoute(
      name: EditPlayerScreen.name,
      path: '/editPlayer',
      builder: (context, state) =>
          EditPlayerScreen(jugador: state.extra as Player),
    ),
    GoRoute(
  path: '/profile',
  builder: (context, state) => const ProfileScreen(),
),
  ],
);
