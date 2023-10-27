import 'package:flutter/material.dart';
import 'package:zipaquira_2/pages/navpages/bumf_page.dart';
import 'package:zipaquira_2/pages/navpages/home_page.dart';
import 'package:zipaquira_2/pages/navpages/main_page.dart';
import 'package:zipaquira_2/pages/navpages/notifications_page.dart';
import 'package:zipaquira_2/pages/profile_pages/forgot_password/change_password.dart';
import 'package:zipaquira_2/pages/profile_pages/forgot_password/forgot_password.dart';
import 'package:zipaquira_2/pages/profile_pages/profile_data_page.dart';
import 'package:zipaquira_2/pages/profile_pages/signup_pages/sign_up_document_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

bool isLoggedIn = false;
String token = "";
String first_name = "";
String last_name = "";
String correo = "";

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    final url = Uri.parse('http://192.168.1.2:8000/login');

    try {
      final response = await http.post(
        url,
        body: {
          'username': email,
          'password': password,
        },
      );
      print("linea 44 ${response.statusCode}");
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        token = responseBody["access"];
        first_name = responseBody["first_name"];
        last_name = responseBody["last_name"];
        correo = responseBody["email"];

        setState(() {
          isLoggedIn =
              true; // Cambia el estado de inicio de sesión a verdadero.
        });

        /* Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChangePassword(token: token,),
              )); */
      } else {
        // El inicio de sesión falló. Muestra un mensaje de error.
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error de inicio de sesión'),
              content:
                  Text('Inicio de sesión fallido. Verifica tus credenciales.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cerrar'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      // Error en la solicitud HTTP. Muestra un mensaje de error.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Si el usuario está conectado, muestra un contenido diferente.
    if (isLoggedIn) {
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
              SizedBox(
                height: 20,
              ),
              Container(
                width: 400,
                height: 540,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.white,
                ),
                child:
                    _buildNavigationList(), // Llama a la función para construir la lista de opciones
              ),
            ],
          ),
        ),
      );
    } else {
      // Si el usuario no está conectado, muestra el formulario de inicio de sesión.
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
              SizedBox(
                height: 40,
              ),
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
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPageID()),
                                );
                              },
                              style: ButtonStyle(backgroundColor: null),
                              child: Text(
                                'Regístrate',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 131, 221, 96),
                                ),
                              ),
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
                        Text(
                          'Ingresa tu correo electrónico',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blueAccent,
                            ),
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: 'Correo electrónico',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(11)),
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
                        Text(
                          'Ingresa tu contraseña',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blueAccent,
                            ),
                          ),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                hintText: 'Contraseña',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(11)),
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
                        login();
                      },
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(250, 48)),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 2, 82, 4)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)))),
                      child: Text(
                        'Iniciar sesión',
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

  Widget _buildNavigationList() {
    final List<Widget> navigationOptions = [
      _buildNavigationItem(Icons.person, 'Mi perfil', Colors.grey),
      _buildNavigationItem(Icons.lock, 'Cambiar contraseña', Colors.grey),
      _buildNavigationItem(Icons.article, 'Noticias', Colors.grey),
      _buildNavigationItem(Icons.tour, 'Turismo', Colors.grey),
      _buildNavigationItem(Icons.notifications, 'Reportes', Colors.grey),
      _buildNavigationItem(Icons.report, 'Enlaces', Colors.grey),
      _buildNavigationItem(Icons.logout, 'Cerrar sesión', Colors.red),
    ];

    return ListView(
      children: navigationOptions,
    );
  }

  Widget _buildNavigationItem(IconData icon, String text, Color iconColor) {
    print("linea 347 $token");
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          leading: Icon(
            icon,
            color: iconColor,
          ),
          title: Text(
            text,
            style: TextStyle(fontSize: 16, color: iconColor),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: iconColor),
          onTap: () {
            if (text == 'Cerrar sesión') {
              setState(() {
                isLoggedIn = false; // Cierra la sesión
              });
            } else if (text == 'Mi perfil') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfileData(
                  correo: correo,
                  first_name: first_name,
                  last_name: last_name,
                ),
              ));
            } else if (text == 'Cambiar contraseña') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChangePassword(
                  token: token,
                ),
              ));
            } else if (text == 'Noticias') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
            } else if (text == 'Turismo') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
            } else if (text == 'Reportes') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NotificationsPage(),
              ));
            } else if (text == 'Enlaces') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BumfPage(),
              ));
            } else {
              // Implementa acciones específicas según la opción seleccionada
              // Puedes usar un switch o if para manejar diferentes acciones
              // ...
            }
          },
        ),
        Divider(
          thickness: 1,
          indent: 14,
          endIndent: 14,
        ),
      ],
    );
  }
}
