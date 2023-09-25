import 'package:flutter/material.dart';

class FullNews extends StatefulWidget {
  const FullNews({super.key});

  @override
  State<FullNews> createState() => _nameState();
}

class _nameState extends State<FullNews> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      
      body: Column(
        children: [
          // Imagen de la noticia (40% superior)
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              
              image: DecorationImage(
                image: AssetImage('assets/noticia1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenedor blanco con detalles de la noticia (60% inferior)
          Expanded(
            child: Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(40),
      topRight: Radius.circular(40),
    ),
    color: const Color.fromARGB(255, 92, 24, 24), // Establece el color de fondo aquí
  ),
  padding: EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Título de la noticia
      Text(
        
        'Policía aumenta seguridad',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          
        ),
      ),
      SizedBox(height: 10),
                  // Rectángulo con logo, ciudad y fecha
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        // Logo pequeño
                        Image.asset(
                          "assets/logo.jpg",
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 10),
                        // Ciudad y fecha (mes abreviado y número del día)
                        Row(
        children: [
          Text(
            "City Hall of Zipaquirá",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey
            ),
          ),
          SizedBox(width: 10),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "Sep 21",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                                ),
                              ),
          ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Texto de la noticia
                  Text(
                    // Aquí debes agregar el texto de la noticia
                    "Este es el texto de la noticia...",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}