import 'package:flutter/material.dart';
import 'package:zipaquira_2/infrastructure/models/camera_gallery_impl.dart';

import 'package:zipaquira_2/pages/navpages/home_page.dart';

import 'package:zipaquira_2/pages/profile_pages/forgot_password/forgot_password.dart';

import 'package:zipaquira_2/pages/profile_pages/signup_pages/sign_up_document_page.dart';


import 'package:geolocator/geolocator.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'dart:convert';

bool isLoggedIn = false;
String token = "";
String first_name = "";
String last_name = "";
String correo = "";
double? altitude;
double? longitude;
bool isLocationAvailable = false;

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String titulo = "";
  String descripcion = "";

  bool isPhotoTaken = false;

  // geolocalizacion

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            'Error: los permisos de ubicación son obligatorios para enviar el reporte');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    isLocationAvailable = false;
    Position position = await determinePosition();
    altitude = position.altitude;
    longitude = position.longitude;
    isLocationAvailable = true;
  }

  Future<void> report(String photoPath) async {
    getCurrentLocation();

    final url = 'http://192.168.1.6:8000/report/';

    try {
      // Crea una instancia de Dio
      Dio dio = Dio();

      // Crea un objeto FormData para adjuntar la imagen
      FormData formData = FormData.fromMap({
        'title': titulo,
        'description': descripcion,
        'location': 'Longitud: $longitude, Altitud: $altitude',
        'correo': correo,
        'image': await MultipartFile.fromFile(
          photoPath,
          filename: 'image.jpg',
        ),
      });

      // Envía la solicitud
      final response = await dio.post(
        url,
        data: formData,
      );

      if (response.statusCode == 200) {
      // El reporte se ha enviado con éxito, muestra un mensaje emergente
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Reporte enviado con éxito'),
          content: Text('Tu reporte se ha enviado correctamente.'),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(); 
                
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ],
        ),
      );
    }
    } catch (error) {
      print('Error al enviar el informe: $error');
      // Maneja el error adecuadamente
    }
  }

  void enviarReporte() async {
    // Obtén la geolocalización
    getCurrentLocation();

    // Verifica si la geolocalización está disponible
    if (isLocationAvailable) {
      // Ahora puedes llamar a la función 'report' con los datos requeridos
      await report(titulo);
    } else {
      // Maneja el caso en el que la geolocalización no esté disponible
      print('La geolocalización no está disponible.');
    }
  }

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    final url = Uri.parse(
        'http://192.168.1.6:8000/login');

    try {
      final response = await http.post(
        url,
        body: {
          'username': email,
          'password': password,
        },
      );

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
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: 400,
                height: 740,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Reportes',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Cuadro de alerta
                    Container(
                        width: 340,
                        height: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(255, 183, 207, 248),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.crisis_alert, // Icono de alerta
                              color: Colors.blueAccent, // Color del icono
                            ),
                            SizedBox(
                              width: 12), // Espacio entre el icono y el texto
                            Expanded(
                              child: Text(
                                'Recuerda agregar tu barrio y dirección en el cuadro de descripción',
                                style: TextStyle(color: Colors.black, fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true, 
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: 20),

                    // Campos de título y descripción
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Título',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Escribe un título',
                              filled:
                                  true, // Rellena el fondo del cuadro de entrada de texto
                              fillColor: Colors
                                  .white, // Color de fondo del cuadro de entrada de texto
                              border: OutlineInputBorder(
                                // Agrega un borde al cuadro de entrada de texto
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ), // Quita los bordes predeterminados
                                borderRadius: BorderRadius.circular(12),
                                // Añade esquinas redondeadas
                              ),
                            ),
                            maxLines: 1,
                            onChanged: (value) {
                              // Actualiza la variable 'titulo' cuando cambia el campo de título
                              setState(() {
                                titulo = value;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Descripción',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                                hintText: 'Escribe una descripción detallada',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  // Agrega un borde al cuadro de entrada de texto
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ), // Quita los bordes predeterminados
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            maxLines: 5,
                            onChanged: (value) {
                              // Actualiza la variable 'descripcion' cuando cambia el campo de descripción
                              setState(() {
                                descripcion = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Botón para tomar una foto
                    Container(
  width: 325,
  height: 50,
  child: ElevatedButton(
    onPressed: () async {
      final cameraStatus = await Permission.camera.request();
      if (cameraStatus.isGranted) {
        final photoPath = await CameraGalleryImpl().takePhoto();
        if (photoPath == null) return;

        // Actualiza el estado para indicar que se ha tomado una foto
        setState(() {
          isPhotoTaken = true;
        });

        report(photoPath);
      } else {
        // El usuario no otorgó permiso para acceder a la cámara
        // Puedes mostrar un mensaje de error o realizar una acción alternativa
        // Por ejemplo, mostrar un SnackBar o AlertDialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('El acceso a la cámara ha sido denegado.'),
          ),
        );
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 50, 118, 53),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: Icon(
      Icons.camera_alt_rounded,
      color: Colors.white,
    ),
  ),
),

                    SizedBox(height: 20),

                    // Botón para enviar
                    Container(
                      width: 325,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          enviarReporte();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isPhotoTaken
                              ? const Color.fromARGB(255, 50, 118, 53)
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Enviar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
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
                height: 10,
              ),
              // Cuadro de fondo blanco
              Container(
                width: 316,
                height: 550,
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
}
