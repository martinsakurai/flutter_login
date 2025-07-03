import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
import 'package:flutter_login/entities/players_provider.dart';
import 'package:go_router/go_router.dart';


class ViewPlayerScreen extends ConsumerWidget {
  static const String name = 'view_player_screen';


  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController goalsController = TextEditingController();
  final TextEditingController appearancesController = TextEditingController();
  final TextEditingController clubsController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController ratioController = TextEditingController();
  final TextEditingController posterUrlController = TextEditingController();
  final Player jugador;


  bool isEditing = false;


  ViewPlayerScreen({super.key, required this.jugador});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles de ${jugador.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ListView ( // si el contenido de la pantalla es extenso, hago que sea scrolleable
            children: [
            const SizedBox(height:10),
            TextFormField(
              initialValue: jugador.name,
              enabled: false,
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Nombre'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.country,
              enabled: false,
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'País'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.goals.toString(),
              enabled: false,
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Goles'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.appearances.toString(),
              enabled: false,
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Partidos'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.clubs,
              enabled: false,
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Clubes'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.age.toString(),
              enabled: false,
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Edad'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.ratio.toString(),
              enabled: false,
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Promedio'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: jugador.posterUrl,
              enabled: false,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Promedio'),
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
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        context.push('/editPlayer', extra: jugador);
      },
      child: const Icon(Icons.edit),
    )
    );
  }
}

