import 'package:get/get.dart';
import 'package:notificaciones_unifront_app/app/data/services/Fcm_service.dart';

class RootLogic extends GetxController {
  @override
  void onReady() {
    _init();
    super.onReady();
  }

  void _init() async {
    FcmService().initNotificaciones();
  }
}
