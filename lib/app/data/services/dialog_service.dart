import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificaciones_unifront_app/app/data/services/auth_service.dart';
import 'package:notificaciones_unifront_app/app/routes/app_pages.dart';

class DialogService extends GetxService {
  static DialogService get to => Get.find();

  void snackBar(Color color, String title, String body) {
    Get.snackbar(
      title,
      body,
      colorText: color,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.easeOutBack,
      margin: const EdgeInsets.all(15),
    );
  }

  void openDialog() {
    Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        barrierDismissible: false);
  }

  void closeSession() {
    Get.dialog(WillPopScope( onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 270,
            height: 135,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                const Text('Su sesión a sido cerrada',style: TextStyle(fontSize: 20),),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () async {
                      final logOut =
                      await AuthService.to.eraseSession(server: false);
                      if (logOut) {
                        Get.rootDelegate.offNamed(Routes.login)  ;
                        Get.back();
                      }
                    },
                    child: const Text('Salir'))
              ],
            ),
          ),
        ),
      ),
    ),barrierDismissible: false);
  }

  void closeDialog() {
    Get.back();
  }
}
