import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
import 'package:flutter_login/entities/players_provider.dart';
import 'package:go_router/go_router.dart';

class AddPlayerScreen extends ConsumerStatefulWidget {
  static const String name = 'add_player_screen';

  const AddPlayerScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends ConsumerState<AddPlayerScreen> {
  final _formKey = GlobalKey<FormState>();

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
      appBar: AppBar(title: const Text('Agregar nuevo jugador')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese un nombre' : null,
              ),
              TextFormField(
                controller: countryController,
                decoration: const InputDecoration(labelText: 'País'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese un país' : null,
              ),
              TextFormField(
                controller: goalsController,
                decoration: const InputDecoration(labelText: 'Goles'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese goles'
                    : int.tryParse(value) == null
                        ? 'Ingrese un número válido'
                        : null,
              ),
              TextFormField(
                controller: appearancesController,
                decoration: const InputDecoration(labelText: 'Partidos'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese partidos'
                    : int.tryParse(value) == null
                        ? 'Ingrese un número válido'
                        : null,
              ),
              TextFormField(
                controller: clubsController,
                decoration: const InputDecoration(labelText: 'Clubes'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese clubes' : null,
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese edad'
                    : int.tryParse(value) == null
                        ? 'Ingrese un número válido'
                        : null,
              ),
              TextFormField(
                controller: ratioController,
                decoration: const InputDecoration(labelText: 'Promedio'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese promedio'
                    : double.tryParse(value) == null
                        ? 'Ingrese un número válido'
                        : null,
              ),
              TextFormField(
                controller: posterUrlController,
                decoration: const InputDecoration(labelText: 'URL de la imagen'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese URL' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newPlayer = Player(
                      name: nameController.text.trim(),
                      country: countryController.text.trim(),
                      goals: int.parse(goalsController.text.trim()),
                      appearances: int.parse(appearancesController.text.trim()),
                      clubs: clubsController.text.trim(),
                      age: int.parse(ageController.text.trim()),
                      ratio: double.parse(ratioController.text.trim()),
                      posterUrl: posterUrlController.text.trim(),
                    );

                    ref.read(playersProvider.notifier).addPlayer(newPlayer);

                    // Regresa a la pantalla anterior
                    context.pop();
                  }
                },
                child: const Text('Agregar jugador'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}