import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart'; // Importa el paquete para lanzar URLs

class BumfPage extends StatelessWidget {
  const BumfPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Color colorbumf = Color.fromARGB(255, 2, 77, 6);
    const double borderRadiusValue = 10.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 71, 32, 42),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen
            Image.asset(
              'assets/bumf.png',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 38),

            // Título
            Text(
              'Enlaces',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 38),
            // Botones con URLs
            _buildButtonWithUrl('Procedimientos', Icons.document_scanner, colorbumf, borderRadiusValue, 'https://www.zipaquira-cundinamarca.gov.co/tema/tramites-y-servicios'),
            SizedBox(height: 38),
            _buildButtonWithUrl('PQRS', Icons.feedback, colorbumf, borderRadiusValue, 'https://www.zipaquira-cundinamarca.gov.co/peticiones-quejas-reclamos'),
            SizedBox(height: 38),
            _buildButtonWithUrl('Contingencias', Icons.crisis_alert, colorbumf, borderRadiusValue, 'https://www.zipaquira-cundinamarca.gov.co/tema/noticias'),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonWithUrl(String text, IconData iconData, Color color, double borderRadius, String url) {
    return Padding(
      
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: InkWell(
        onTap: () {
          launchUrlString(url); // Lanza la URL cuando se toca el botón
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              bottomLeft: Radius.circular(borderRadius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: color,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(borderRadius),
                    bottomRight: Radius.circular(borderRadius),
                  ),
                ),
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


 
}
