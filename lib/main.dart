import 'package:flutter/material.dart';

import 'package:zipaquira_2/pages/navpages/home_page.dart';





void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        
          useMaterial3: true,
          primaryColor: Colors.green
          
        ),
        
        debugShowCheckedModeBanner: false,
       home: HomePage(),
        );
  }
}
