import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificaciones_unifront_app/app/data/services/auth_service.dart';
import 'package:notificaciones_unifront_app/app/routes/app_pages.dart';

import 'root_logic.dart';

class RootPage extends StatelessWidget {
  final logic = Get.find<RootLogic>();

  RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(builder: (context, delegate, current) {
      return Scaffold(
        body: GetRouterOutlet(
            initialRoute:
                AuthService.to.jwt != null ? Routes.home : Routes.login),
      );
    });
  }
}
