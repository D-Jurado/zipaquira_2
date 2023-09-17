import 'package:flutter/material.dart';
import 'package:zipaquira_2/pages/navpages/profile_page.dart';

class SignUpSuccessPage extends StatefulWidget {
  const SignUpSuccessPage({Key? key}) : super(key: key);

  @override
  State<SignUpSuccessPage> createState() => _SignUpSuccessPageState();
}

class _SignUpSuccessPageState extends State<SignUpSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 2, 54, 4),
              Color.fromRGBO(184, 212, 50, 1),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen
            Image.asset(
              'assets/logo_profile.png',
              width: double.infinity,
              height: 200,
            ),
            SizedBox(height: 40),
            // Cuadro de fondo blanco
            Container(
              width: 316,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Registrarse',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 54,
                  ),
                  // Columna con imagen y párrafo
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/email-check.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(left: 6, right: 6),
                        child: Text(
                          '¡Operación exitosa! Se ha enviado un correo electrónico de confirmación a su dirección de correo electrónico registrada. Revise su bandeja de entrada (y su carpeta de correo no deseado) para completar el proceso de registro.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Botón Siguiente
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfilePage();
                          },
                        ),
                        
                      );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(250, 48)),
                      backgroundColor:
                          MaterialStateProperty.all(Color.fromARGB(255, 2, 82, 4)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child: Text(
                      'Regresa al inicio de sesión',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


