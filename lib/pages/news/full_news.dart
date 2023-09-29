import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:zipaquira_2/infrastructure/models/local_news_model.dart';



class FullNews extends StatefulWidget {
  final LocalNewsModel? localNewsInformation;

  const FullNews(this.localNewsInformation);

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
            height: 420,
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
            top: 330,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(55),
                  topRight: Radius.circular(55),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                          widget.localNewsInformation!.title!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Rectángulo con logo, ciudad y fecha
                      Container(
                        width: 320,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            // Logo pequeño
                            Image.asset(
                              "assets/logo.jpg",
                              width: 40,
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
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  widget.localNewsInformation!
                                      .getFormattedDate(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 15), // Margen alrededor del texto
                        child: Text(
                            // Aquí debes agregar el texto de la noticia
                            widget.localNewsInformation!.body!,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                                                  ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Floating Action Button en la esquina superior izquierda con bordes blancos
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white,
                    width: 0.4,
                  ),
                ),
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 20
                      // Color del ícono
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
