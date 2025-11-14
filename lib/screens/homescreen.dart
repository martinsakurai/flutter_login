import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/new_players_provider.dart';
import 'package:flutter_login/entities/favorites_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  User? usuarioFirebase;

  @override
  void initState() {
    super.initState();

    usuarioFirebase = FirebaseAuth.instance.currentUser;

    Future.microtask(() {
      ref.read(newPlayersProvider.notifier).getAllPlayers();
    });
  }

  @override
  Widget build(BuildContext context) {
    // si no está logueado, lo manda al login
    if (usuarioFirebase == null) {
      Future.microtask(() => context.go('/'));
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final jugadores = ref.watch(newPlayersProvider);

    //favoritos por uid
    final favoritos = ref.watch(favoritesProvider(usuarioFirebase!.uid));

    // ordenar favoritos primero
    final jugadoresOrdenados = [...jugadores];
    jugadoresOrdenados.sort((a, b) {
      final aFav = favoritos.contains(a.id);
      final bFav = favoritos.contains(b.id);
      return (bFav ? 1 : 0) - (aFav ? 1 : 0);
    });

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('usuarios')
              .doc(usuarioFirebase!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("Cargando usuario...");
            }

            final data = snapshot.data!.data() as Map<String, dynamic>?;

            final nombre = data?['nombre'] ?? 'Usuario';

            return Text('Bienvenido, $nombre');
          },
        ),
        actions: [
          // ir al perfil
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Mi Perfil',
            onPressed: () {
              context.push('/profile');
            },
          ),

          // logout
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) context.go('/');
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // email del usuario
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Correo: ${usuarioFirebase?.email ?? 'No disponible'}',
              style: const TextStyle(fontSize: 16),
            ),
          ),

          // lista de jugadores
          Expanded(
            child: ListView.builder(
              itemCount: jugadoresOrdenados.length,
              itemBuilder: (context, index) {
                final jugador = jugadoresOrdenados[index];
                final esFavorito = favoritos.contains(jugador.id);

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    onTap: () {
                      context.push('/viewPlayer', extra: jugador);
                    },
                    leading: Image.network(
                      jugador.posterUrl ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
                    title: Text(jugador.name ?? 'Sin nombre'),
                    subtitle: Text(
                      'País: ${jugador.country ?? 'Desconocido'}\n'
                      'Goles: ${jugador.goals}\n'
                      'Partidos: ${jugador.appearances}\n'
                      'Promedio: ${jugador.ratio}\n'
                      'Clubes: ${jugador.clubs ?? 'N/A'}',
                    ),

                    // favoritos
                    trailing: IconButton(
                      icon: Icon(
                        esFavorito ? Icons.favorite : Icons.favorite_border,
                        color: esFavorito ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        ref
                            .read(favoritesProvider(usuarioFirebase!.uid)
                                .notifier)
                            .toggleFavorite(jugador.id!);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/addPlayer');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}