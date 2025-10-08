import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
import 'package:flutter_login/entities/new_players_provider.dart';
import 'package:go_router/go_router.dart';

class ViewPlayerScreen extends ConsumerStatefulWidget {
  static const String name = 'view_player_screen';

  final Player jugador;
  const ViewPlayerScreen({super.key, required this.jugador});

  @override
  ConsumerState<ViewPlayerScreen> createState() => _ViewPlayerScreenState();
}

class _ViewPlayerScreenState extends ConsumerState<ViewPlayerScreen> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: widget.jugador.name);
    final countryController = TextEditingController(text: widget.jugador.country);
    final goalsController = TextEditingController(text: widget.jugador.goals.toString());
    final appearancesController = TextEditingController(text: widget.jugador.appearances.toString());
    final clubsController = TextEditingController(text: widget.jugador.clubs);
    final ageController = TextEditingController(text: widget.jugador.age.toString());
    final ratioController = TextEditingController(text: widget.jugador.ratio.toString());
    final posterUrlController = TextEditingController(text: widget.jugador.posterUrl);

    return Scaffold(
      appBar: AppBar(title: Text('Detalles de ${widget.jugador.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              enabled: isEditing,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Nombre'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: countryController,
              enabled: isEditing,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'País'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: goalsController,
              enabled: isEditing,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Goles'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: appearancesController,
              enabled: isEditing,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Partidos'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: clubsController,
              enabled: isEditing,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Clubes'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: ageController,
              enabled: isEditing,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Edad'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: ratioController,
              enabled: isEditing,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Promedio'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: posterUrlController,
              enabled: isEditing,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'URL de la imagen'),
            ),
            const SizedBox(height: 30),

            if (isEditing)
              ElevatedButton(
                onPressed: () async {
                  final editedPlayer = widget.jugador.copyWith(
                    name: nameController.text,
                    country: countryController.text,
                    goals: int.parse(goalsController.text),
                    appearances: int.parse(appearancesController.text),
                    clubs: clubsController.text,
                    age: int.parse(ageController.text),
                    ratio: double.parse(ratioController.text),
                    posterUrl: posterUrlController.text,
                  );

                  await ref.read(newPlayersProvider.notifier).removePlayer(widget.jugador);
                  await ref.read(newPlayersProvider.notifier).addPlayer(editedPlayer);

                  setState(() => isEditing = false);
                  context.pop();
                },
                child: const Text('GUARDAR CAMBIOS'),
              )
            else
              ElevatedButton(
                onPressed: () async {
                  await ref.read(newPlayersProvider.notifier).removePlayer(widget.jugador);
                  context.pop();
                },
                child: const Text('BORRAR'),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => isEditing = !isEditing),
        child: Icon(isEditing ? Icons.close : Icons.edit),
      ),
    );
  }
}