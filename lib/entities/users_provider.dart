import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'users.dart';

final usersProvider = StateNotifierProvider<UsersNotifier, List<User>>((ref) {
  return UsersNotifier();
});

class UsersNotifier extends StateNotifier<List<User>> {
  UsersNotifier() : super([]);

  final CollectionReference<User> _usersCollection = FirebaseFirestore.instance
      .collection('usuarios')
      .withConverter<User>(
        fromFirestore: (snapshot, _) => User.fromFirestore(snapshot),
        toFirestore: (user, _) => user.toFirestore(),
      );

  Future<void> getAllUsers() async {
    try {
      final querySnapshot = await _usersCollection.get();
      state = querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error al obtener usuarios de Firebase: $e');
    }
  }

}