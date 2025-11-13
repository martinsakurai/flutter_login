import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> _login() async {
    try {
      // Validación de campos vacíos
      if (inputUsuario.text.isEmpty || inputContrasena.text.isEmpty) {
        mensaje = "⚠️ COMPLETE TODOS LOS CAMPOS";
        colorFondo = Colors.orange;
        _showSnackBar();
        return;
      }

      // Intentar iniciar sesión con Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: inputUsuario.text.trim(),
        password: inputContrasena.text.trim(),
      );

      // Si llega hasta acá, el login fue exitoso
      if (mounted) {
        context.go('/home');
      }
    } on FirebaseAuthException catch (e) {
      // Errores comunes de Firebase traducidos
      switch (e.code) {
        case 'user-not-found':
          mensaje = "EMAIL NO REGISTRADO";
          break;
        case 'wrong-password':
          mensaje = "CONTRASEÑA INCORRECTA";
          break;
        case 'invalid-email':
          mensaje = "FORMATO DE EMAIL INVÁLIDO";
          break;
        case 'user-disabled':
          mensaje = "USUARIO DESHABILITADO";
          break;
        default:
          mensaje = "❌ EMAIL O CONTRASEÑA INCORRECTA";
      }
      colorFondo = Colors.red;
      _showSnackBar();
    } catch (e) {
      // Otros errores no controlados
      mensaje = "⚠️ Ocurrió un error inesperado";
      colorFondo = Colors.red;
      _showSnackBar();
    }
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensaje,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: colorFondo,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Bienvenido a MECA-LOGIN",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: inputUsuario,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Correo electrónico',
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
                    labelText: 'Contraseña',
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
                onPressed: _login,
                child: const Text('Ingresar'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  context.push('/register'); // Navega a la pantalla de registro
                },
                child: const Text("¿No tienes cuenta? Registrate aquí"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
