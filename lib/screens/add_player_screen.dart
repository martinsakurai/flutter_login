import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
import 'package:flutter_login/entities/new_players_provider.dart';
import 'package:go_router/go_router.dart';

class AddPlayerScreen extends ConsumerStatefulWidget {
  static const String name = 'add_player_screen';

  const AddPlayerScreen({super.key});

  @override
  ConsumerState<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends ConsumerState<AddPlayerScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController goalsController = TextEditingController();
  final TextEditingController appearancesController = TextEditingController();
  final TextEditingController clubsController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController ratioController = TextEditingController();
  final TextEditingController posterUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar jugador')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: countryController,
              decoration: const InputDecoration(
                labelText: 'País',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: goalsController,
              decoration: const InputDecoration(
                labelText: 'Goles',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: appearancesController,
              decoration: const InputDecoration(
                labelText: 'Partidos',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: clubsController,
              decoration: const InputDecoration(
                labelText: 'Clubes',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: ratioController,
              decoration: const InputDecoration(
                labelText: 'Promedio',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: posterUrlController,
              decoration: const InputDecoration(
                labelText: 'URL de la imagen',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final newPlayer = Player(
                  name: nameController.text.trim(),
                  country: countryController.text.trim(),
                  goals: int.tryParse(goalsController.text) ?? 0,
                  appearances: int.tryParse(appearancesController.text) ?? 0,
                  clubs: clubsController.text.trim(),
                  age: int.tryParse(ageController.text) ?? 0,
                  ratio: double.tryParse(ratioController.text) ?? 0.0,
                  posterUrl: posterUrlController.text.trim(),

                  // favorito siempre empieza falso
                  isFavorite: false,
                );

                await ref
                    .read(newPlayersProvider.notifier)
                    .addPlayer(newPlayer);

                context.pop(); // vuelve a la homescreen
              },
              child: const Text('AGREGAR JUGADOR'),
            ),
          ],
        ),
      ),
    );
  }
}