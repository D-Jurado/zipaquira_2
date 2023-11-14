import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:zipaquira_2/config/local_notifications.dart';
import 'package:zipaquira_2/dependency_injection.dart';

import 'package:zipaquira_2/pages/navpages/home_page.dart';
import 'package:zipaquira_2/presentation/blocs/notifications_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await NotificationsBloc.initializeFCM();
  await LocalNotifications.initializeLocalNotifications();

  initializeDateFormatting('es');
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => NotificationsBloc(),
      )
    ],
    child: const MyApp(),
  ));
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 2, 54, 4),
                Color.fromRGBO(184, 212, 50, 1),
              ],
            ),
          ),
          child: Center(
            child: Image.asset(
              'assets/logo_profile.png',
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
            ),
          ),
        ));
  }
}
