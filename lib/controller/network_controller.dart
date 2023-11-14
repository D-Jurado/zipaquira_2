import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      if (Get.isDialogOpen != null && Get.isDialogOpen!) {
        Get.back(); 
      }
      
      Get.dialog(
        AlertDialog(
          title: const Text('No hay conexión'),
          content: const Text('Se necesita internet para utilizar la app'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Cierra el AlertDialog
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      if (Get.isDialogOpen != null && Get.isDialogOpen!) {
        Get.back(); // Cierra el AlertDialog si está abierto
      }
    }
  }
}
