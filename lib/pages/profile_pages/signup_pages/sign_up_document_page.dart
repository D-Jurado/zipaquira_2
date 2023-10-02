import 'package:flutter/material.dart';
import 'package:zipaquira_2/pages/profile_pages/signup_pages/sign_up_name_page.dart';

class SignUpPageID extends StatefulWidget {
  const SignUpPageID({Key? key}) : super(key: key);

  @override
  State<SignUpPageID> createState() => _SignUpPageIDState();
}

class _SignUpPageIDState extends State<SignUpPageID> {
  String? documentNumber;
  String? documentType;
  List<String> options = ['CC', 'TI', 'CE'];

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
        child: SingleChildScrollView(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('No tienes cuenta?'),
                            TextButton(
                              onPressed: () {
                                // Agregar la lógica para redireccionar a la página de registro aquí.
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
                    // Campos de entrada de texto para tipo de documento y número de documento
                    buildDropdownField(
                      label: 'Selecciona tipo de documento',
                      hintText: 'Tipo de documento',
                      onChanged: (newValue) {
                        setState(() {
                          documentType = newValue;
                        });
                      },
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    buildTextField(
                      label: 'Ingresa tu número de documento',
                      hintText: 'Número de documento',
                      onChanged: (value) {
                        setState(() {
                          documentNumber = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Verificar si se llenaron ambos campos
                        if (documentType != null &&
                            documentNumber != null &&
                            documentNumber!.isNotEmpty) {
                          // Ambos campos están llenos, puedes navegar a la siguiente página
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SignUpNamePage(
                                  documentType: documentType!,
                                  documentNumber: documentNumber!,
                                );
                              },
                            ),
                          );
                        } else {
                          // Mostrar un mensaje de error si los campos están vacíos
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Campos obligatorios'),
                                content: Text(
                                  'Por favor, completa ambos campos antes de continuar.',
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
                        minimumSize:
                            MaterialStateProperty.all(Size(250, 48)),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 2, 82, 4)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
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
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hintText,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
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
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget buildDropdownField({
    required String label,
    required String hintText,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
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
          child: DropdownButtonFormField<String>(
            value: documentType,
            items: options.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }
}
