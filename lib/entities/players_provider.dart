import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'users.dart';

// Un StateNotifier para la lista de jugadores
class PlayersNotifier extends StateNotifier<List<Player>> {
  PlayersNotifier(): super(List.from(Player.playerList));

  void addPlayer(Player newPlayer) {
    state = [...state, newPlayer];
  }
}

final playersProvider = StateNotifierProvider<PlayersNotifier, List<Player>>((ref) {
  return PlayersNotifier();
});
