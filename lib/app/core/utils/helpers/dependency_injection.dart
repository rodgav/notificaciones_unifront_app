import 'package:get/get.dart';
import 'package:notificaciones_unifront_app/app/core/utils/helpers/encrypt_helper.dart';
import 'package:notificaciones_unifront_app/app/core/utils/helpers/http/http.dart';
import 'package:notificaciones_unifront_app/app/data/provider/db_provider.dart';
import 'package:notificaciones_unifront_app/app/data/repositorys/db_repository.dart';

class DependencyInjection {
  static void init() {
    final _http = Http();
    Get.put<EncryptHelper>(EncryptHelper());
    Get.put<DbProvider>(DbProvider(_http));
    Get.put<DbRepository>(DbRepository());
  }
}
