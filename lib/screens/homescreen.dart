import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
//import 'package:flutter_login/entities/players_provider.dart';
import 'package:flutter_login/entities/new_players_provider.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  static const String name = 'home_screen';

  final User usuarioIngresado;

  const HomeScreen({super.key, required this.usuarioIngresado});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jugadores = ref.watch(newPlayersProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido, ${usuarioIngresado.nombre}')),
      body: ListView.builder(
        itemCount: jugadores.length,
        itemBuilder: (context, index) {
          final jugador = jugadores[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
                onTap: () {context.push('/viewPlayer', extra: jugador,);},
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
                'Goles: ${jugador.goals}, Partidos: ${jugador.appearances}, Promedio: ${jugador.ratio.toString()}\n'
                'Clubes: ${jugador.clubs}',
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // cambio a la pantalla para agregar jugador
          context.push('/addPlayer');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}