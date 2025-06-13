import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_login/entities/users.dart';

List<User> usuarios = [
  User(
    email: 'martin@gmail.com',
    contrasena: 'MarSaku07',
    nombre: 'Martin Sakurai',
    direccion: 'Avenida 9 de Julio 123',
  ),
  User(
    email: 'federico@gmail.com',
    contrasena: 'fede',
    nombre: 'Federico Rodriguez',
    direccion: 'Avenida de Mayo 742',
  ),
  User(
    email: 'mateo@gmail.com',
    contrasena: 'mateogonzalez',
    nombre: 'Mateo Gonzalez',
    direccion: 'Avenida Santa Fe 555',
  ),
  User(
    email: 'luis@gmail.com',
    contrasena: 'luisito',
    nombre: 'Luis Ramírez',
    direccion: 'Sarmiento 400',
  ),
  User(
    email: 'sofia@gmail.com',
    contrasena: 'sofia7',
    nombre: 'Sofía Méndez',
    direccion: 'Avenida Rivadavia 89',
  ),
];

class LoginScreen extends StatefulWidget {
  static const String name = 'loginscreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController inputUsuario = TextEditingController();
  final TextEditingController inputContrasena = TextEditingController();
  String comprobacion = '';
  bool mostrarContrasena = false;
  String mensaje = '';
  Color colorFondo = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Bienvenido a MECA-LOGIN"),
            const SizedBox(height: 20),
            Text(comprobacion),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: inputUsuario,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Introduzca su correo electronico',
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

                for(var usuario in usuarios){
                  if(usuario.email == inputUsuario.text) {
                    usuarioEncontrado = usuario;
                  }
                }

                if (inputUsuario.text.isEmpty || inputContrasena.text.isEmpty) {
                  mensaje = "⚠️ COMPLETE TODOS LOS CAMPOS";
                  colorFondo = Colors.orange;
                }else if (usuarioEncontrado == null){
                  mensaje = "EMAIL NO REGISTRADO";
                  colorFondo = Colors.red;
                }
                else if(inputContrasena.text != usuarioEncontrado.contrasena){
                  mensaje = "CONTRASEÑA INCORRECTA";
                  colorFondo = Colors.red;
                }
                 else {
                  // si todo esta bien
                  context.go('/home', extra: usuarioEncontrado); // se pone el path definido en el router, en este caso, /home.con "extra" le envio informacion a la homescreen. En este caso, le paso la clase con todos los atributos. Luego en la homescreen imprimire los que necesite (solo nombre y direccion)
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