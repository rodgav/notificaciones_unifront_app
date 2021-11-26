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

  @override
  void onReady() {
    if (AuthService.to.role == 'Apoderado') {
      onChangeStudent(null);
    } else {
      StudentService.to.estudianteSet = AuthService.to.sub ?? '0';
      Get.rootDelegate.toNamed(Routes.nextPending);
    }
    super.onReady();
  }

  void onChangeStudent(String? currentLocation) async {
    final token = await AuthService.to.getToken();
    if (token != null) {
      EstudianteModel? _estudianteModel =
          await _dbRepository.getEstudiantesForApoderado(token: token);
      Estudiante? _estudiante = await _dbRepository.getEstudiante(token: token);
      if (_estudianteModel != null) {
        Get.dialog(Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: 300,
              height: 350,
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
                  Text(
                    _estudianteModel.estudiantes.isNotEmpty
                        ? 'Cambiar de estudiante'
                        : 'Estudiante',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _estudianteModel.estudiantes.isNotEmpty
                        ? ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (__, index) {
                              final student =
                                  _estudianteModel.estudiantes[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: const Color(0xff1E4280),
                                  child: Text(student.name.substring(0, 2)),
                                ),
                                title: Text(
                                  '${student.name} ${student.lastname}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  StudentService.to.estudianteSet =
                                      student.id.toString();
                                  if (currentLocation == null ||
                                      currentLocation == '/home/inbox' ||
                                      currentLocation == '/') {
                                    Get.rootDelegate
                                        .toNamed(Routes.nextPending);
                                  } else {
                                    Get.rootDelegate.toNamed(Routes.inbox);
                                  }
                                  _closeDialog();
                                },
                              );
                            },
                            separatorBuilder: (__, index) => const Divider(),
                            itemCount: _estudianteModel.estudiantes.length)
                        : _estudiante != null
                            ? ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: const Color(0xff1E4280),
                                  child: Text(_estudiante.name.substring(0, 2)),
                                ),
                                title: Text(
                                  '${_estudiante.name} ${_estudiante.lastname}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : const Center(
                                child: Text('Sin datos'),
                              ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff1E4280),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: _logOut,
                        child: const Text('Cerrar sesión')),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _estudianteModel.estudiantes.isNotEmpty
                        ? 'Estos son los estudiantes vinculados a su cuenta.'
                        : 'Esta es tu cuenta de estudiante',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ));
      } else {
        DialogService.to
            .snackBar(Colors.red, 'Error', 'No se encontro el estudiante');
      }
    } else {
      Get.rootDelegate.toNamed(Routes.login);
    }
  }

  void _closeDialog() {
    Get.back();
  }

  void _logOut() async {
    final logOut = await AuthService.to.eraseSession();
    if (logOut) {
      Get.rootDelegate.offNamed(Routes.login);
      Get.back();
    } else {
      DialogService.to.snackBar(
          Colors.red, 'ERROR', 'No se pudo cerrar sesión, intentelo mas tarde');
    }
  }
}
