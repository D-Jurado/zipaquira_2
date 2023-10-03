import 'package:flutter/material.dart';
import 'package:zipaquira_2/pages/navpages/bumf_page.dart';
import 'package:zipaquira_2/pages/navpages/home_page.dart';
import 'package:zipaquira_2/pages/navpages/main_page.dart';
import 'package:zipaquira_2/pages/navpages/notifications_page.dart';
import 'package:zipaquira_2/pages/profile_pages/forgot_password/forgot_password.dart';
import 'package:zipaquira_2/pages/profile_pages/profile_data_page.dart';
import 'package:zipaquira_2/pages/profile_pages/signup_pages/sign_up_document_page.dart';
import 'package:http/http.dart' as http;

bool isLoggedIn = false;

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

    final url = Uri.parse(
        'http://192.168.1.5:8000/login'); // Reemplaza con la URL de tu API de inicio de sesión

    try {
      final response = await http.post(
        url,
        body: {
          'username': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // El inicio de sesión fue exitoso.
        // Puedes agregar lógica adicional aquí si es necesario.
        setState(() {
          isLoggedIn = true; // Cambia el estado de inicio de sesión a verdadero.
        });
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
                height: 40,
              ),
              Container(
                width: 400,
                height: 520,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.white,
                ),
                child: _buildNavigationList(), // Llama a la función para construir la lista de opciones
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
    // Opciones de navegación con íconos y texto
    final List<Widget> navigationOptions = [
      _buildNavigationItem(Icons.person, 'Mi perfil', Colors.grey), // Cambia el color del ícono
      _buildNavigationItem(Icons.article, 'Noticias', Colors.grey), // Cambia el color del ícono
      _buildNavigationItem(Icons.tour, 'Turismo', Colors.grey), // Cambia el color del ícono
      _buildNavigationItem(Icons.notifications, 'Notificaciones', Colors.grey), // Cambia el color del ícono
      _buildNavigationItem(Icons.report, 'Reportes',Colors.grey), // Cambia el color del ícono
      _buildNavigationItem(Icons.logout, 'Cerrar sesión', Colors.red), // Cambia el color del ícono y texto
    ];

    return ListView(
      children: navigationOptions,
    );
  }

  Widget _buildNavigationItem(IconData icon, String text, Color iconColor) {
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
          trailing: Icon(Icons.arrow_forward_ios, color: iconColor), // Agregar el icono ">" a la derecha
          onTap: () {
            // Implementa la lógica para cada opción aquí
            if (text == 'Cerrar sesión') {
              // Cierra la sesión y regresa a la pantalla de inicio de sesión
              setState(() {
                isLoggedIn = false; // Cierra la sesión
              });
            } else if (text == 'Mi perfil') {
            // Navega a la página ProfileData
            Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileData(),)
                                );
            } else if (text == 'Noticias') {
            // Navega a la página ProfileData
            Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(),)
                                );
            } else if (text == 'Turismo') {
            // Navega a la página ProfileData
            Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(),)
                                );
            } else if (text == 'Notificaciones') {
            // Navega a la página ProfileData
            Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationsPage(),)
                                );
            } else if (text == 'Reportes') {
            // Navega a la página ProfileData
            Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BumfPage(),)
                                ); 
            } else {
              // Implementa acciones específicas según la opción seleccionada
              // Puedes usar un switch o if para manejar diferentes acciones
              // ...
            }
          },
        ),
        Divider(
          thickness: 1, // Grosor de la línea
          indent: 16, // Espacio en la izquierda
          endIndent: 16, // Espacio en la derecha
        ),
      ],
    );
  }
}
