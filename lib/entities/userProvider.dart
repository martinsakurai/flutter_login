import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'users.dart';

final newUsersProvider = StateNotifierProvider<NewUsersNotifier, List<Player>>((ref) {
  return NewPlayersNotifier();
});

class UsersNotifier extends StateNotifier<List<User>> {
  NewUsersNotifier() : super([]);

  final CollectionReference<Player> _playersCollection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<User>(
        fromFirestore: (snapshot, _) => User.fromFirestore(snapshot),
        toFirestore: (user, _) => player.toFirestore(),
      );

  Future<void> getAllPlayers() async {
    try {
      final querySnapshot = await _playersCollection.get();
      state = querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error al obtener usuarios de Firebase: $e');
    }
  }

  Future<void> addUser(User user)) async {
    try {
      final docRef = await _playersCollection.add(player);
      player.id = docRef.id;
      state = [...state, user];
    } catch (e) {
      print('Error al agregar jugador a Firebase: $e');
    }
  }

Future<void> updatePlayer(Player player) async {
  if (player.id == null) return;
  try {
    await _playersCollection.doc(player.id).set(player);
    state = [
      for (final p in state)
        if (p.id == player.id) player else p,
    ];
  } catch (e) {
    print('Error al actualizar jugador en Firebase: $e');
  }
}

  Future<void> removePlayer(Player player) async {
    if (player.id == null) return;
    try {
      await _playersCollection.doc(player.id).delete();
      state = state.where((p) => p.id != player.id).toList();
    } catch (e) {
      print('Error al eliminar jugador de Firebase: $e');
    }
  }
}