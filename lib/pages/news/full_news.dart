import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class FullNews extends StatefulWidget {
  const FullNews({Key? key});

  @override
  State<FullNews> createState() => _FullNewsState();
}

class _FullNewsState extends State<FullNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de la noticia (40% superior)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 380,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/noticia1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Contenedor blanco con detalles de la noticia (60% inferior)
          Positioned(
            top: 350,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Título de la noticia
                      Text(
                        'Policía aumenta seguridad',
                        style: TextStyle(
                          fontSize: 32,
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
                                    color: Colors.grey,
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
                      // Texto de la noticia con margen
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 15), // Margen alrededor del texto
                        child: Text(
                          // Aquí debes agregar el texto de la noticia
                          loremIpsum(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
