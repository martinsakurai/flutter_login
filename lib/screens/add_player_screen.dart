import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
import 'package:flutter_login/entities/players_provider.dart';
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
      appBar: AppBar(title: const Text('Agregar nuevo jugador')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Nombre'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: countryController,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'País'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: goalsController,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Goles'),
                keyboardType: TextInputType.number, // utilizamos teclado numerico para ingresar los goles, esto es para evitar errores mas que nada 
              ),
              SizedBox(height: 10),
              TextField(
                controller: appearancesController,
                decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Partidos'),
                keyboardType: TextInputType.number, //utilizamos teclado numerico para ingresar los partidos, esto es para evitar errores mas que nada
              ),
              SizedBox(height: 10),
              TextField(
                controller: clubsController,
                decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Clubes'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Edad'),
                keyboardType: TextInputType.number, //utilizamos teclado numerico para ingresar la edad, esto es para evitar errores mas que nada
              ),
              SizedBox(height: 10),
              TextField(
                controller: ratioController,
                decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Promedio'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true), //utilizamos un teclado numerico
              ),
              SizedBox(height: 10),
              TextField(
                controller: posterUrlController,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'URL de la imagen'),
              ),
              SizedBox(height: 10),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                    final newPlayer = Player(
                      name: nameController.text,
                      country: countryController.text,
                      goals: int.parse(goalsController.text), //convertimos a int el texto ingresado por el usuario
                      appearances: int.parse(appearancesController.text), // convertimos a int el texto ingresado por el usuario
                      clubs: clubsController.text,
                      age: int.parse(ageController.text), // convertimos a int el texto ingresado por el usuario
                      ratio: double.parse(ratioController.text), // convertimos a float/double el texto ingresado por el usuario
                      posterUrl: posterUrlController.text,
                    );

                    ref.read(playersProvider.notifier).addPlayer(newPlayer);

                    // Regresa a la pantalla anterior
                    context.pop();
                  
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