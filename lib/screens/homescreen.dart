import 'package:flutter/material.dart';
import 'package:flutter_login/entities/users.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';

  final User usuarioIngresado; // uso final ya que estamos en un Statless widget. Como StatelessWidget no cambia su estado, sus propiedades deberían ser final
  final jugadores = Player.playerList;

  HomeScreen({super.key, required this.usuarioIngresado}); //aca se dice que se requiere el userName de la pantalla login, la variable esta declarada igual que en appRouter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido, ${usuarioIngresado.nombre}'),),
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
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
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
    );
  }
}