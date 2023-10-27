import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zipaquira_2/pages/navpages/profile_page.dart';
import 'package:zipaquira_2/pages/navpages/bumf_page.dart';
import 'package:zipaquira_2/pages/navpages/main_page.dart';
import 'package:zipaquira_2/pages/navpages/reports_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zipaquira_2/presentation/blocs/notifications/notifications_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [MainPage(), BumfPage(), ReportsPage(), ProfilePage()];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkNotificationPermission();
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Future<void> _checkNotificationPermission() async {
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      // Si los permisos no están autorizados, muestra el cuadro de diálogo de solicitud
      _showPermissionsDialog();
      print(settings.authorizationStatus);
    }
  }

  void _showPermissionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Solicitud de Permisos"),
          content: Text(
              "Por favor, otorga los permisos necesarios para recibir notificaciones."),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Otorgar Permisos"),
              onPressed: () {
                _requestNotificationPermission();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _requestNotificationPermission() async {
    final status = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    if (status == AuthorizationStatus.authorized) {
      // Los permisos fueron otorgados, puedes continuar con la página principal
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 13,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(label: 'Inicio', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: "Enlaces", icon: Icon(Icons.date_range_sharp)),
          BottomNavigationBarItem(
              label: "Reportes", icon: Icon(Icons.notification_add_rounded)),
          BottomNavigationBarItem(
              label: "Perfil", icon: Icon(Icons.person_2_sharp)),
        ],
      ),
    );
  }
}
