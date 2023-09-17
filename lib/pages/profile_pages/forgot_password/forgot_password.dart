import 'package:flutter/material.dart';
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
                          // Agregar lógica para enviar el correo de restablecimiento de contraseña aquí
                          if (emailAddress != null &&
                              emailAddress!.isNotEmpty) {
                            // Envía el correo y navega a la página de éxito
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotSuccessPage(),
                              ),
                            );
                          } else {
                            // Muestra un mensaje de error si el campo de correo está vacío
                            setState(() {
                              message =
                                  'Por favor, ingresa tu dirección de correo electrónico antes de continuar.';
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
                      Navigator.of(context).pop(
                        MaterialPageRoute(builder: (context) {
                          return ForgotSuccessPage();
                        }, 
                        )
                      );
                      
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
