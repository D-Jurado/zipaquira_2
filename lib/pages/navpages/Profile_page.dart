
import 'package:flutter/material.dart';
import 'package:zipaquira_2/pages/profile_pages/forgot_password/forgot_password.dart';
import 'package:zipaquira_2/pages/profile_pages/signup_pages/sign_up_document_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            SizedBox(height: 40,),
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
                        'Iniciar sesión',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('No tienes cuenta?'),
                          TextButton(
                            onPressed: () {
                               Navigator.push(
                               context,
                            MaterialPageRoute(builder: (context) => SignUpPageID()),
                               );
                            },
                            style: ButtonStyle(backgroundColor: null),
                            child: Text('Regístrate',
                            style: TextStyle(
                              color: Color.fromARGB(255, 131, 221, 96), 
                            ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  // Campos de entrada de texto para correo electrónico y contraseña
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ingresa tu correo electrónico',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 10,),
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
                            hintText: '    Correo electrónico',
                            border: InputBorder.none, 
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ingresa tu contraseña',
                       style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 10,),
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
                            hintText: '    Contraseña',
                            border: InputBorder.none, 
                          ),
                          obscureText: true, 
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                           Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordPage();
                            },
                          ),
                        );
                          },
                          child: Text(
                            'Olvidé mi contraseña',
                            style: TextStyle(
                              color: Color.fromARGB(255, 131, 221, 96), 
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Agregar la lógica de inicio de sesión aquí.
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(250, 48)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 2, 82, 4)), 
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))
                    ),
                    child: Text('Iniciar sesión',
                    style: TextStyle(
                              color: Colors.white
                            ),),
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