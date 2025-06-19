import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
import 'package:flutter_login/entities/players_provider.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  static const String name = 'home_screen';

  final User usuarioIngresado;

  HomeScreen({super.key, required this.usuarioIngresado});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jugadores = ref.watch(playersProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido, ${usuarioIngresado.nombre}')),
      body: ListView.builder(
        itemCount: jugadores.length,
        itemBuilder: (context, index) {
          final jugador = jugadores[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(
                jugador.posterUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image),
              ),
              title: Text(jugador.name),
              subtitle: Text(
                'País: ${jugador.country}\n'
                'Goles: ${jugador.goals}, Partidos: ${jugador.appearances}, Promedio: ${jugador.ratio.toStringAsFixed(2)}\n'
                'Clubes: ${jugador.clubs}',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega a la pantalla para agregar jugador
          context.go('/addPlayer');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}