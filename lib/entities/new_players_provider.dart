import 'package:flutter_login/entities/players_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
//necesitamos hacer un nuevo provider que me devuelva la lista de jugadores, sin firebase, es decir, usando StateNotifierProvider
final playersProvider = StateNotifierProvider<PlayersNotifier, List<Player>>(
  (ref) => PlayersNotifier(),
);

  class PlayersProvider extends StateNotifier<List<Player>> {
  void getAllPlayers(List<Player> PLAYERSList) {
    final listaJugadores = 
    state = [...state, ...PLAYERSList];
  }
}