import 'package:get/get.dart';
import 'package:notificaciones_unifront_app/app/data/models/estudiante_model.dart';

class StudentService extends GetxService {
  static StudentService get to => Get.find();

  final _estudiante = Estudiante(
          id: 0,
          idapoderado: 0,
          name: '',
          lastname: '',
          correo: '',
          idSubNivel: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now())
      .obs;

  Estudiante get estudiante => _estudiante.value;

  set estudianteSet(Estudiante? student) {
    if (student != null) {
      _estudiante.value = student;
    } else {
      _estudiante.value = Estudiante(
          id: 0,
          idapoderado: 0,
          name: '',
          lastname: '',
          correo: '',
          idSubNivel: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
    }
  }
}
