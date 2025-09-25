import 'package:cloud_firestore/cloud_firestore.dart';

/// ------------------ USUARIOS ------------------
class User {
  String? id; // ID de Firebase
  String email;
  String contrasena;
  String nombre;
  String direccion;

  User({
    this.id,
    required this.email,
    required this.contrasena,
    required this.nombre,
    required this.direccion,
  });

  // Para enviar a Firebase
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'contrasena': contrasena,
      'nombre': nombre,
      'direccion': direccion,
    };
  }

  // Para crear un User desde Firebase
  factory User.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return User(
      id: doc.id,
      email: data['email'] ?? '',
      contrasena: data['contrasena'] ?? '',
      nombre: data['nombre'] ?? '',
      direccion: data['direccion'] ?? '',
    );
  }
}

/// ------------------ JUGADORES ------------------
class Player {
  String? id; // ID de Firebase
  String name;
  String country;
  int goals;
  int appearances;
  String clubs;
  int age;
  double ratio;
  String posterUrl;

  Player({
    this.id,
    required this.name,
    required this.country,
    required this.goals,
    required this.appearances,
    required this.clubs,
    required this.age,
    required this.ratio,
    required this.posterUrl,
  });

  // Para enviar a Firebase
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'country': country,
      'goals': goals,
      'appearances': appearances,
      'clubs': clubs,
      'age': age,
      'ratio': ratio,
      'posterUrl': posterUrl,
    };
  }

  // Para crear un Player desde Firebase
  factory Player.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Player(
      id: doc.id,
      name: data['name'] ?? '',
      country: data['country'] ?? '',
      goals: (data['goals'] ?? 0),
      appearances: (data['appearances'] ?? 0),
      clubs: data['clubs'] ?? '',
      age: (data['age'] ?? 0),
      ratio: (data['ratio'] ?? 0.0).toDouble(),
      posterUrl: data['posterUrl'] ?? '',
    );
  }

  // Método copyWith para clonar un Player modificando solo los campos que quieras
  Player copyWith({
    String? id,
    String? name,
    String? country,
    int? goals,
    int? appearances,
    String? clubs,
    int? age,
    double? ratio,
    String? posterUrl,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      goals: goals ?? this.goals,
      appearances: appearances ?? this.appearances,
      clubs: clubs ?? this.clubs,
      age: age ?? this.age,
      ratio: ratio ?? this.ratio,
      posterUrl: posterUrl ?? this.posterUrl,
    );
  }
}