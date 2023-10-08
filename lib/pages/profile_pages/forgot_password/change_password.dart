import 'package:flutter/material.dart';
import 'package:zipaquira_2/pages/profile_pages/signup_pages/sign_up_name_page.dart';
import 'package:zipaquira_2/pages/profile_pages/signup_pages/sign_up_success_page.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? password;
  String? newPassword;

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
                        'Cambiar contraseña',
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
                  // Campos de entrada de texto para contraseña y confirmación de contraseña
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ingrese su contraseña',
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
                            hintText: '   Contraseña',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onChanged: (value) {
                            setState(() {
                              password =
                                  value; // Asigna el valor del campo de entrada de texto a password
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nueva contraseña',
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
                            hintText: '   Contraseña',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onChanged: (value) {
                            setState(() {
                              newPassword =
                                  value; // Asigna el valor del campo de entrada de texto a confirmPassword
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Verificar si se llenaron ambos campos y si las contraseñas coinciden
                      if (password != null &&
                          newPassword != null &&
                          password!.isNotEmpty 
                          ) {
                        // Crear un mapa con los datos que deseas enviar a la API
                        Map<String, dynamic> updatePassword = {
                          'current_password': password,
                          'new_password': newPassword,
                        };

                        // URL de tu API
                        String apiUrl =
                            'http://192.168.1.5:8000/users/update-password';

                        // Realizar la solicitud HTTP POST a la API
                        try {
                          final response = await http.post(
                            Uri.parse(apiUrl),
                            body: updatePassword,
                          );
                          print(response.statusCode);
                          if (response.statusCode == 200) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Cambio exitoso'),
                                  content: Text(
                                      'Tu contraseña se ha cambiado con éxito.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Cierra el cuadro de diálogo de éxito
                                        Navigator.of(context)
                                            .pop(); // Cierra la página actual para regresar a la página anterior
                                      },
                                      child: Text('Cerrar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            // Mostrar un mensaje de error si la solicitud falla
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Error en la solicitud'),
                                  content: Text(response.body),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } catch (error) {
                          // Mostrar un mensaje de error si la solicitud falla
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Error en la solicitud'),
                                content:
                                    Text('Contraseña actual no es correcta'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        // Mostrar un mensaje de error si las contraseñas no coinciden
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error de contraseña'),
                              content: Text(
                                  'Las contraseñas no coinciden. Por favor, verifique e intente de nuevo.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(250, 48)),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 2, 82, 4)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)))),
                    child: Text(
                      'Confirmar',
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
