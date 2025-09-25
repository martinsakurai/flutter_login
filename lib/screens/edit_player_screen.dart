import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
import 'package:flutter_login/entities/new_players_provider.dart';
import 'package:go_router/go_router.dart';

class EditPlayerScreen extends ConsumerStatefulWidget {
  static const String name = 'edit_player_screen';
  final Player jugador;

  const EditPlayerScreen({super.key, required this.jugador});

  @override
  ConsumerState<EditPlayerScreen> createState() => _EditPlayerScreenState();
}

class _EditPlayerScreenState extends ConsumerState<EditPlayerScreen> {
  late TextEditingController nameController;
  late TextEditingController countryController;
  late TextEditingController goalsController;
  late TextEditingController appearancesController;
  late TextEditingController clubsController;
  late TextEditingController ageController;
  late TextEditingController ratioController;
  late TextEditingController posterUrlController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.jugador.name);
    countryController = TextEditingController(text: widget.jugador.country);
    goalsController = TextEditingController(text: widget.jugador.goals.toString());
    appearancesController = TextEditingController(text: widget.jugador.appearances.toString());
    clubsController = TextEditingController(text: widget.jugador.clubs);
    ageController = TextEditingController(text: widget.jugador.age.toString());
    ratioController = TextEditingController(text: widget.jugador.ratio.toString());
    posterUrlController = TextEditingController(text: widget.jugador.posterUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar jugador')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: countryController, decoration: const InputDecoration(labelText: 'País', border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: goalsController, decoration: const InputDecoration(labelText: 'Goles', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            TextField(controller: appearancesController, decoration: const InputDecoration(labelText: 'Partidos', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            TextField(controller: clubsController, decoration: const InputDecoration(labelText: 'Clubes', border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: ageController, decoration: const InputDecoration(labelText: 'Edad', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            TextField(controller: ratioController, decoration: const InputDecoration(labelText: 'Promedio', border: OutlineInputBorder()), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
            const SizedBox(height: 10),
            TextField(controller: posterUrlController, decoration: const InputDecoration(labelText: 'URL de la imagen', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updatedPlayer = widget.jugador.copyWith(
                  name: nameController.text,
                  country: countryController.text,
                  goals: int.parse(goalsController.text),
                  appearances: int.parse(appearancesController.text),
                  clubs: clubsController.text,
                  age: int.parse(ageController.text),
                  ratio: double.parse(ratioController.text),
                  posterUrl: posterUrlController.text,
                );

                await ref.read(newPlayersProvider.notifier).updatePlayer(updatedPlayer);
                context.pop();
              },
              child: const Text('GUARDAR CAMBIOS'),
            ),
          ],
        ),
      ),
    );
  }
}
