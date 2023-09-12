import 'package:flutter/material.dart';

class BumfPage extends StatelessWidget {
  const BumfPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Color colorbumf = Color.fromARGB(255, 2, 77, 6);
    const double borderRadiusValue = 10.0;
    return Scaffold(
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
              'Bumf',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 38),
            // text  icons
            _buildButton('Procedimientos', Icons.document_scanner, colorbumf, borderRadiusValue),
            SizedBox(height: 38),
            _buildButton('PQRS', Icons.feedback, colorbumf, borderRadiusValue),
            SizedBox(height: 38),
            _buildButton('Contingencias', Icons.crisis_alert, colorbumf, borderRadiusValue),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, IconData iconData, Color color, double borderRadius) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
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
                fontSize: 22,
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
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  iconData,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


