import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'users.dart'; // Aquí están las clases Player y User

class PlayersNotifier extends StateNotifier<List<Player>> {
  // inicializa el estado con la lista estatica de jugadores
  PlayersNotifier() : super(List.from(Player.playerList));

  // metodo para obtener todos los jugadores
  void getAllPlayers() {
    state = [...Player.playerList]; // state es la lista de Player (List<Player>). Cuando usamos el = le estamos diciendo a riverpod que actualice el estado y notifique a todos los widgets que estan escuchando (ref.watch)
  //Player.playerList es la lista estatica original definida en users.dart
  // ... se usa para copiar los elementos de una lista en otra lista. Esto crea una lista independiente
  }
}

final newPlayersProvider = StateNotifierProvider<PlayersNotifier, List<Player>>(
  (ref) => PlayersNotifier(),
);
