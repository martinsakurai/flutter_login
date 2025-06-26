import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'users.dart';

// notifier que maneja la lista de jugadores
class PlayersNotifier extends StateNotifier<List<Player>> {
  PlayersNotifier() : super(List.from(Player.playerList)); // Clona la lista inicial

  // metodo para agregar un nuevo jugador
  void addPlayer(Player newPlayer) { // le paso al nuevo jugador como parametro
    state = [...state, newPlayer];
  }

  // metodo para eliminar un jugador
void removePlayer(Player playerRemove) { //le paso un jugador como parametro
  state.removeWhere((p) => p == playerRemove);
  state = [...state]; // para actualizar el estado con una nueva lista
}
}

// provider
final playersProvider = StateNotifierProvider<PlayersNotifier, List<Player>>((ref) {
  return PlayersNotifier();
});