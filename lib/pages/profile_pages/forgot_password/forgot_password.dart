import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zipaquira_2/pages/navpages/profile_page.dart';
import 'package:zipaquira_2/pages/profile_pages/forgot_password/forgot_success_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? emailAddress;
  String? message = ''; // Mensaje de éxito o error

  Future<void> sendPasswordResetEmail() async {
    final url = Uri.parse('http://192.168.1.5:8000/users/reset-password');

    try {
      final response = await http.post(
        url,
        body: json.encode({'email': emailAddress}),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Éxito: el correo se ha enviado con éxito
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotSuccessPage(),
          ),
        );
      } else if(response.statusCode == 404) {
        // Error en la solicitud HTTP, muestra un mensaje de error.
        setState(() {
          message = 'Correo electronico no encontrado';
        });
      };
    } catch (error) {
      // Error en la solicitud HTTP, muestra un mensaje de error.
      setState(() {
        message = 'Ha ocurrido un error inesperado. Inténtalo de nuevo más tarde.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        'Olvidaste la contraseña?',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  // Campo de entrada de texto para correo electrónico
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ingresa tu correo electrónico',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.blueAccent,
                          ),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Correo electrónico',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onChanged: (value) {
                            setState(() {
                              emailAddress = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  // Botones
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Verifica que el correo no esté vacío antes de enviar la solicitud
                          if (emailAddress != null && emailAddress!.isNotEmpty) {
                            sendPasswordResetEmail();
                          } else {
                            setState(() {
                              message = 'Por favor, ingresa tu dirección de correo electrónico antes de continuar.';
                            });
                          }
                        },
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(200, 48)),
                          backgroundColor:
                              MaterialStateProperty.all(Color.fromARGB(255, 2, 82, 4)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        child: Text(
                          'Enviar Correo',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      // Navegar de regreso a la página de inicio de sesión
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(200, 48)),
                      backgroundColor:
                          MaterialStateProperty.all(Color.fromARGB(255, 2, 82, 4)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child: Text(
                      'Regresar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20,),
                  // Mensaje de éxito o error
                  if (message != null && message!.isNotEmpty)
                    Text(
                      message!,
                      style: TextStyle(
                        color: Colors.red,
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
