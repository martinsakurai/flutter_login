import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
import 'package:flutter_login/entities/new_players_provider.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String name = 'home_screen';
  final User usuarioIngresado;

  const HomeScreen({super.key, required this.usuarioIngresado});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar jugadores desde Firebase al iniciar la pantalla
    Future.microtask(() =>
        ref.read(newPlayersProvider.notifier).getAllPlayers());
  }

  @override
  Widget build(BuildContext context) {
    final jugadores = ref.watch(newPlayersProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido, ${widget.usuarioIngresado.nombre}')),
      body: ListView.builder(
        itemCount: jugadores.length,
        itemBuilder: (context, index) {
          final jugador = jugadores[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                context.push('/viewPlayer', extra: jugador);
              },
              leading: Image.network(
                jugador.posterUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image),
              ),
              title: Text(jugador.name),
              subtitle: Text(
                'País: ${jugador.country}\n'
                'Goles: ${jugador.goals}, Partidos: ${jugador.appearances}, Promedio: ${jugador.ratio}\n'
                'Clubes: ${jugador.clubs}',
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/addPlayer');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}