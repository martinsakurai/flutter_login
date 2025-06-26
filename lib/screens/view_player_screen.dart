import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
import 'package:flutter_login/entities/players_provider.dart';
import 'package:go_router/go_router.dart';

class ViewPlayerScreen extends ConsumerWidget {
  static const String name = 'view_player_screen';

  final Player jugador;

  const ViewPlayerScreen({super.key, required this.jugador});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle de ${jugador.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ListView ( // si el contenido de la pantalla es extenso, hago que sea scrolleable
            children: [
            TextFormField(
              initialValue: jugador.name,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.country,
              enabled: false,
              decoration: const InputDecoration(labelText: 'País'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.goals.toString(),
              enabled: false,
              decoration: const InputDecoration(labelText: 'Goles'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.appearances.toString(),
              enabled: false,
              decoration: const InputDecoration(labelText: 'Partidos'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.clubs,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Clubes'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.age.toString(),
              enabled: false,
              decoration: const InputDecoration(labelText: 'Edad'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.ratio.toString(),
              enabled: false,
              decoration: const InputDecoration(labelText: 'Promedio'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.posterUrl,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Promedio'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ref.read(playersProvider.notifier).removePlayer(jugador);
                context.pop();
              },
              child: const Text('BORRAR'),
            )
            ],
        ),
      ),
    ),
    );
  }
}