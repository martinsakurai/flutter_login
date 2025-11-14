import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesNotifier extends StateNotifier<List<String>> {
  FavoritesNotifier(this.uid) : super([]) {
    _loadFavorites();
  }

  final String uid;
  final _db = FirebaseFirestore.instance;

  Future<void> _loadFavorites() async {
    final doc = await _db.collection('favoritos').doc(uid).get();

    if (doc.exists) {
      state = List<String>.from(doc.data()?['players'] ?? []);
    }
  }

  Future<void> toggleFavorite(String playerId) async {
    if (state.contains(playerId)) {
      state = [...state]..remove(playerId);
    } else {
      state = [...state, playerId];
    }

    await _db.collection('favoritos').doc(uid).set({
      'players': state,
    });
  }
}

final favoritesProvider = StateNotifierProvider.family<FavoritesNotifier, List<String>, String>((ref, uid) {
  return FavoritesNotifier(uid);
});
