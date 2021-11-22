import 'package:get/get.dart';

class StudentService extends GetxService {

  static StudentService get to => Get.find();

  String? _estudiante;

  String? get estudiante => _estudiante;

  set estudianteSet(String? value) {
    _estudiante = value;
  }
}