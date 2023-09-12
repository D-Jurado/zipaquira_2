import 'package:flutter/material.dart';

class BumfPage extends StatelessWidget {
  const BumfPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Color colorbumf = Color.fromARGB(255, 2, 77, 6);
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
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Procedimientos',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: colorbumf,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: colorbumf
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.document_scanner,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 38), 

            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PQRS',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: colorbumf,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: colorbumf
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.feedback,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 38), 

            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Contingencias',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: colorbumf,
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: colorbumf
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.crisis_alert,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

