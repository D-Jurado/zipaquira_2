import 'package:flutter/material.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Crear una instancia de User con datos ficticios (reemplaza con los datos reales)
    final user = User(
      nombre: 'Nombre del usuario',
      apellido: 'Apellido del usuario',
      correo: 'correo@ejemplo.com',
    );

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
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserField("Nombre", user.nombre),
                  _buildUserField("Apellido", user.apellido),
                  _buildUserField("Correo", user.correo),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserField(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black, 
            ),
          ),
          SizedBox(height: 6),
          Container(
            width: 300,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Clase User para representar los datos del usuario
class User {
  final String nombre;
  final String apellido;
  final String correo;

  User({
    required this.nombre,
    required this.apellido,
    required this.correo,
  });
}
