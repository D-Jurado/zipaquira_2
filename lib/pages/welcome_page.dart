import 'package:flutter/material.dart';




class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage( image: AssetImage('assets/welcome.jpg'),
        /* fit: BoxFit.cover, */
        ),
      
      ),
      
    );
  }
}

