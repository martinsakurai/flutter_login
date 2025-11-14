import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  static const String name = 'profile_screen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  final _nombreCtrl = TextEditingController();
  final _direccionCtrl = TextEditingController();

  bool cargando = true;
  String? emailUsuario;

  bool editarNombre = false;
  bool editarDireccion = false;

  /// 🔵 Nombre que se muestra arriba (NO cambia mientras escribís)
  String nombreOriginal = "";

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final user = _auth.currentUser;
    if (user == null) return;

    emailUsuario = user.email;

    final doc =
        await _db.collection('usuarios').doc(user.uid).get();

    final data = doc.data();

    _nombreCtrl.text = data?['nombre'] ?? '';
    _direccionCtrl.text = data?['direccion'] ?? '';

    nombreOriginal = _nombreCtrl.text; // 🔵 Guardamos el nombre ORIGINAL

    setState(() {
      cargando = false;
    });
  }

  Future<void> _guardarCambios() async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _db.collection('usuarios').doc(user.uid).update({
      'nombre': _nombreCtrl.text.trim(),
      'direccion': _direccionCtrl.text.trim(),
    });

    // 🔵 Actualizamos el título después de guardar
    setState(() {
      nombreOriginal = _nombreCtrl.text.trim();
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Cambios guardados correctamente"),
        backgroundColor: Colors.green,
      ),
    );

    context.pop(); // Vuelve al Home (donde también se actualiza)
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Perfil"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔵 TÍTULO (NO cambia mientras editás)
            Text(
              "Bienvenido a tu perfil, $nombreOriginal",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // EMAIL — solo lectura
            const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: TextEditingController(text: emailUsuario),
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.black12,
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- NOMBRE ----------------
            const Text("Nombre completo",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nombreCtrl,
                    readOnly: !editarNombre,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor:
                          editarNombre ? Colors.white : Colors.black12,
                      filled: true,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    editarNombre ? Icons.check : Icons.edit,
                    color: editarNombre ? Colors.green : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      editarNombre = !editarNombre;
                    });
                  },
                )
              ],
            ),

            const SizedBox(height: 25),

            // ---------------- DIRECCIÓN ----------------
            const Text("Dirección",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _direccionCtrl,
                    readOnly: !editarDireccion,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor:
                          editarDireccion ? Colors.white : Colors.black12,
                      filled: true,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    editarDireccion ? Icons.check : Icons.edit,
                    color: editarDireccion ? Colors.green : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      editarDireccion = !editarDireccion;
                    });
                  },
                )
              ],
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _guardarCambios,
                child: const Text("Guardar cambios"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
