import 'package:flutter_login/screens/add_player_screen.dart';
import 'package:flutter_login/screens/homescreen.dart';
import 'package:flutter_login/screens/loginscreen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_login/entities/users.dart';

final routerApp = GoRouter(routes: [
  GoRoute(
    name: LoginScreen.name,
    path: '/',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    name: HomeScreen.name,
    path: '/home',
    builder: (context, state) =>
        HomeScreen(usuarioIngresado: state.extra as User),
  ),
  GoRoute(
    name: AddPlayerScreen.name,
    path: '/addPlayer',
    builder: (context, state) => const AddPlayerScreen(),
  ),
]);