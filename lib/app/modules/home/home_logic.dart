import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificaciones_unifront_app/app/data/models/estudiante_model.dart';
import 'package:notificaciones_unifront_app/app/data/repositorys/db_repository.dart';
import 'package:notificaciones_unifront_app/app/data/services/auth_service.dart';
import 'package:notificaciones_unifront_app/app/data/services/dialog_service.dart';
import 'package:notificaciones_unifront_app/app/data/services/student_service.dart';
import 'package:notificaciones_unifront_app/app/routes/app_pages.dart';

class HomeLogic extends GetxController {
  final _dbRepository = Get.find<DbRepository>();
  EstudianteModel? _estudianteModel;

  @override
  void onReady() {
    if (AuthService.to.role == 'Apoderado') {
      _getStudents();
    } else {
      StudentService.to.estudianteSet = AuthService.to.sub ?? '0';
      Get.rootDelegate.toNamed(Routes.nextPending);
    }
    super.onReady();
  }

  void _getStudents() async {
    final token = await AuthService.to.getToken();
    if (token != null) {
      _estudianteModel =
          await _dbRepository.getEstudiantesForApoderado(token: token);
    } else {
      Get.rootDelegate.toNamed(Routes.login);
    }
  }

  void onChangeStudent(Size size, String? currentLocation) {
      if (_estudianteModel != null) {
        Get.dialog(Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.38,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 30,
                      ),
                      onTap: _closeDialog,
                    ),
                  ),
                  const Text(
                    'Cambiar de estudiante',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _estudianteModel!.estudiantes.isNotEmpty
                        ? ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (__, index) {
                              final student =
                                  _estudianteModel!.estudiantes[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: const Color(0xff1E4280),
                                  child: Text(student.name.substring(0, 2)),
                                ),
                                title: Text(
                                  student.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  StudentService.to.estudianteSet =
                                      student.id.toString();
                                  if (currentLocation != null) {
                                    if (currentLocation == '/home/inbox' ||
                                        currentLocation == '/') {
                                      Get.rootDelegate
                                          .toNamed(Routes.nextPending);
                                    } else {
                                      Get.rootDelegate.toNamed(Routes.inbox);
                                    }
                                  }
                                  _closeDialog();
                                },
                              );
                            },
                            separatorBuilder: (__, index) => const Divider(),
                            itemCount: _estudianteModel!.estudiantes.length)
                        : const Center(
                            child: Text('No hay estudiantes'),
                          ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width * 0.75,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff1E4280),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: _logOut,
                        child: const Text('Cerrar sesión')),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Estos son los estudiantes vinculados a su cuenta.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ));
      } else {
        DialogService.to.snackBar(
            Colors.red, 'ERROR', 'Usted no tiene estudiantes añadidos');
      }
  }

  void _closeDialog() {
    Get.back();
  }

  void _logOut() async {
    final logOut = await AuthService.to.eraseSession();
    if (logOut) {
      Get.rootDelegate.toNamed(Routes.login);
    } else {
      DialogService.to.snackBar(
          Colors.red, 'ERROR', 'No se pudo cerrar sesión, intentelo mas tarde');
    }
  }
}
