import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificaciones_unifront_app/app/data/repositorys/db_repository.dart';
import 'package:notificaciones_unifront_app/app/data/services/auth_service.dart';
import 'package:notificaciones_unifront_app/app/data/services/dialog_service.dart';
import 'package:notificaciones_unifront_app/app/data/services/fcm_service.dart';
import 'package:notificaciones_unifront_app/app/routes/app_pages.dart';

class LoginLogic extends GetxController {
  final _dbRepository = Get.find<DbRepository>();
  final TextEditingController correoCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? _typeUser;

  String? get typeUser => _typeUser;

  /*@override
  void onReady() {
    correoCtrl.text ='katia@gmail.com';
    passwordCtrl.text ='12345678';
    // correoCtrl.text ='rodo@gmail.com';
    //passwordCtrl.text ='rodo';
    //correoCtrl.text ='sinapoderado@gmail.com';
    //passwordCtrl.text ='sinapoderado';
    super.onReady();
  }*/

  String? validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return (!regex.hasMatch(value ?? '')) ? 'Ingrese su correo' : null;
  }

  String? isNotEmpty(String? value, String text) {
    if (value != null) if (value.isNotEmpty) return null;
    return text;
  }

  void onChangeTypeUser(String? value) {
    _typeUser = value;
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      final token = await FcmService().getToken();
      if (typeUser == 'Apoderado') {
        DialogService.to.openDialog();
        final tokenModel = await _dbRepository.loginApoderado(
            correo: correoCtrl.text.trim(),
            password: passwordCtrl.text.trim(),
            token: token.toString());
        DialogService.to.closeDialog();
        if (tokenModel != null) {
          if (tokenModel.jwt != null) {
            await AuthService.to.saveSession(tokenModel, 'Apoderado');
            Get.rootDelegate.toNamed(Routes.home);
          } else {
            DialogService.to.snackBar(Colors.red, 'Error', tokenModel.message);
          }
        } else {
          DialogService.to.snackBar(
              Colors.red, 'Error', 'Usuario y contraseña incorrectos');
        }
      } else {
        DialogService.to.openDialog();
        final tokenModel = await _dbRepository.loginEstudiante(
            correo: correoCtrl.text.trim(),
            password: passwordCtrl.text.trim(),
            token: token.toString());
        DialogService.to.closeDialog();
        if (tokenModel != null) {
          if (tokenModel.jwt != null) {
            await AuthService.to.saveSession(tokenModel, 'Estudiante');
            Get.rootDelegate.toNamed(Routes.home);
          } else {
            DialogService.to.snackBar(Colors.red, 'Error', tokenModel.message);
          }
        } else {
          DialogService.to.snackBar(
              Colors.red, 'Error', 'Usuario y contraseña incorrectos');
        }
      }
    }
  }
}
