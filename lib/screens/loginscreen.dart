import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_login/entities/users.dart';
import 'package:flutter_login/entities/users_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String name = 'loginscreen';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController inputUsuario = TextEditingController();
  final TextEditingController inputContrasena = TextEditingController();
  bool mostrarContrasena = false;
  String mensaje = '';
  Color colorFondo = Colors.green;

  @override
  void initState() {
    super.initState();
    // Traer los usuarios de Firebase al iniciar la pantalla
    ref.read(usersProvider.notifier).getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    final usuarios = ref.watch(usersProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Bienvenido a MECA-LOGIN"),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: inputUsuario,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Introduzca su correo electrónico',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                obscureText: !mostrarContrasena,
                controller: inputContrasena,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Introduzca su contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      mostrarContrasena
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        mostrarContrasena = !mostrarContrasena;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                User? usuarioEncontrado;

                for (var usuario in usuarios) {
                  if (usuario.email == inputUsuario.text) {
                    usuarioEncontrado = usuario;
                    break;
                  }
                }

                if (inputUsuario.text.isEmpty || inputContrasena.text.isEmpty) {
                  mensaje = "⚠️ COMPLETE TODOS LOS CAMPOS";
                  colorFondo = Colors.orange;
                } else if (usuarioEncontrado == null) {
                  mensaje = "EMAIL NO REGISTRADO";
                  colorFondo = Colors.red;
                } else if (inputContrasena.text != usuarioEncontrado.contrasena) {
                  mensaje = "CONTRASEÑA INCORRECTA";
                  colorFondo = Colors.red;
                } else {
                  // Login exitoso
                  context.go('/home', extra: usuarioEncontrado);
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(mensaje),
                    backgroundColor: colorFondo,
                    duration: const Duration(seconds: 4),
                  ),
                );
              },
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}