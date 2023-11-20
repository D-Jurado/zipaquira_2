import 'package:flutter/material.dart';
import 'package:zipaquira_2/pages/profile_pages/signup_pages/sign_up_name_page.dart';
import 'package:zipaquira_2/pages/profile_pages/signup_pages/sign_up_success_page.dart';
import 'package:http/http.dart' as http;

class SignUpPasswordPage extends StatefulWidget {
  final String? documentType;
  final String? documentNumber;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;

  const SignUpPasswordPage({
    Key? key,
    this.documentType,
    this.documentNumber,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
  }) : super(key: key);

  @override
  State<SignUpPasswordPage> createState() => _SignUpPasswordPageState();
}

class _SignUpPasswordPageState extends State<SignUpPasswordPage> {
  String? password;
  String? confirmPassword;

  bool isStrongPassword(String password) {
    if (password.length < 8) {
      return false;
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return false; // No hay al menos una letra mayúscula.
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return false; // No hay al menos un número.
    }
    if (!RegExp(r'[!@#\$%^&*.()_+{}|:<>?]').hasMatch(password)) {
      return false; // No hay al menos un símbolo.
    }
    return true;
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
                        'Registrarse',
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
                        'Confirme su contraseña',
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
                              confirmPassword =
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
                          confirmPassword != null &&
                          password!.isNotEmpty &&
                          password == confirmPassword) {
                        if (isStrongPassword(password!)) {
                          // Crear un mapa con los datos que deseas enviar a la API
                          Map<String, dynamic> userData = {
                            'username': widget.email,
                            'email': widget.email,
                            'first_name': widget.firstName,
                            'last_name': widget.lastName,
                            'password': password,
                            'documentType': widget.documentType,
                            'documentNumber': widget.documentNumber,
                            'phone': widget.phone,
                          };
                          print(userData);
                          // URL de tu API
                          String apiUrl =
                              'http://192.168.1.5:8000/users/register';

                          // Realizar la solicitud HTTP POST a la API
                          try {
                            final response = await http.post(
                              Uri.parse(apiUrl),
                              body: userData,
                            );
                            print(response.statusCode);
                            if (response.statusCode == 201) {
                              // Si la solicitud se completó exitosamente, puedes navegar a la página de éxito
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SignUpSuccessPage();
                                  },
                                ),
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
                                  content: Text(
                                      'Hubo un problema al registrar el usuario. Por favor, inténtelo de nuevo más tarde.'),
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
                          // Mostrar un mensaje de error si la contraseña no cumple con los requisitos
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Error de contraseña'),
                                content: Text(
                                  'La contraseña debe tener al menos 8 caracteres, un símbolo, una mayúscula y un número.',
                                ),
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
                                'Las contraseñas no coinciden. Por favor, verifique e intente de nuevo.',
                              ),
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
                        borderRadius: BorderRadius.circular(12),
                      )),
                    ),
                    child: Text(
                      'Siguiente',
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
