import 'package:flutter/material.dart';
import 'package:zipaquira_2/pages/profile_pages/signup_pages/sign_up_password_pages.dart';

class SignUpNamePage extends StatefulWidget {
  const SignUpNamePage({
    Key? key,
    required this.documentType,
    required this.documentNumber,
  }) : super(key: key);

  final String documentType;
  final String documentNumber;

  @override
  State<SignUpNamePage> createState() => _SignUpNamePageState();
}

class _SignUpNamePageState extends State<SignUpNamePage> {
  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? phone;
  String? email;

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
              Image.asset(
                'assets/logo_profile.png',
                width: double.infinity,
                height: 200,
              ),
              SizedBox(height: 20),
              Container(
                width: 316,
                height: 600,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
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
                        height: 24,
                      ),
                      buildTextField(
                        label: 'Nombre',
                        hintText: 'Nombre',
                        onChanged: (value) {
                          setState(() {
                            firstName = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      buildTextField(
                        label: 'Apellido',
                        hintText: 'Apellido',
                        onChanged: (value) {
                          setState(() {
                            lastName = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      buildTextField(
                        label: 'Teléfono',
                        hintText: 'Teléfono',
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                        isPhoneNumber: true,
                      ),
                      SizedBox(height: 20),
                      buildTextField(
                        label: 'Correo electrónico',
                        hintText: 'Correo electrónico',
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        isEmail: true,
                      ),
                      SizedBox(
                        height: 34,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Validar que todos los campos sean válidos
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUpPasswordPage(
                                    documentType: widget.documentType,
                                    documentNumber: widget.documentNumber,
                                    firstName: firstName,
                                    lastName: lastName,
                                    phone: phone,
                                    email: email,
                                  );
                                },
                              ),
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
                                    borderRadius: BorderRadius.circular(12))),
                        ),
                        child: Text(
                          'Siguiente',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
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
    bool isPhoneNumber = false,
    bool isEmail = false,
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
          child: TextFormField(
            onChanged: onChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              } else if (isPhoneNumber && !isNumeric(value)) {
                return 'Solo se permiten números';
              } else if (isEmail && !isEmailValid(value)) {
                return 'Formato de correo no válido';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }

  bool isNumeric(String value) {
    return int.tryParse(value) != null;
  }

  bool isEmailValid(String value) {
    final RegExp regex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
      caseSensitive: false,
    );
    return regex.hasMatch(value);
  }
}
