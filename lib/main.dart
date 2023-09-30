import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:zipaquira_2/pages/navpages/home_page.dart';


void main() {
  initializeDateFormatting('es');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}