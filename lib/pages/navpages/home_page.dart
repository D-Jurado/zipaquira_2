import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zipaquira_2/pages/navpages/profile_page.dart';
import 'package:zipaquira_2/pages/navpages/bumf_page.dart';
import 'package:zipaquira_2/pages/navpages/main_page.dart';
import 'package:zipaquira_2/pages/navpages/reports_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zipaquira_2/presentation/blocs/notifications_bloc.dart';

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
          title:  const Text('Notificaciones'),
          content: const Text(
              "Por favor, otorga los permisos necesarios para recibir notificaciones."),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Otorgar Permisos"),
              onPressed: () {
                context.read<NotificationsBloc>().requestPermission();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              label: "Reportes", icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(
              label: "Perfil", icon: Icon(Icons.person_2_sharp)),
        ],
      ),
    );
  }
}
