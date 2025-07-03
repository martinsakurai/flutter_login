import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
import 'package:flutter_login/entities/players_provider.dart';
import 'package:go_router/go_router.dart';

class EditPlayerScreen extends ConsumerStatefulWidget {
  static const String name = 'edit_player_screen';

  final Player jugador;

  const EditPlayerScreen({super.key, required this.jugador});

  @override
  ConsumerState<EditPlayerScreen> createState() => _EditPlayerScreenState();
}

class _EditPlayerScreenState extends ConsumerState<EditPlayerScreen> {
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
      appBar: AppBar(title: const Text('Editar jugador')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Nombre'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: widget.jugador.country,
              controller: countryController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'País'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: widget.jugador.goals.toString(),
              controller: goalsController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Goles'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: widget.jugador.appearances.toString(),
              controller: appearancesController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Partidos'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: widget.jugador.clubs,
              controller: clubsController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Clubes'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: widget.jugador.age.toString(),
              controller: ageController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Edad'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: widget.jugador.ratio.toString(),
              controller: ratioController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Promedio'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: widget.jugador.posterUrl,
              controller: posterUrlController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'URL de la imagen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // priemro borro el jugador viejo y despues guardo el nuevo
                ref.read(playersProvider.notifier).removePlayer(widget.jugador);
                ref.read(playersProvider.notifier).addPlayer(
                  Player(
                    name: nameController.text,
                    country: countryController.text,
                    goals: int.parse(goalsController.text),
                    appearances: int.parse(appearancesController.text),
                    clubs: clubsController.text,
                    age: int.parse(ageController.text),
                    ratio: double.parse(ratioController.text),
                    posterUrl: posterUrlController.text,
                  ),
                );

                // vuelvo a la homescreen
                context.go('/home');
              },
              child: const Text('GUARDAR'),
            )
          ],
        ),
      ),
    );
  }
}