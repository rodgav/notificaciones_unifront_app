import 'package:get/get.dart';
import 'package:notificaciones_unifront_app/app/data/models/estudiante_model.dart';
import 'package:notificaciones_unifront_app/app/data/models/notificaciones_model.dart';
import 'package:notificaciones_unifront_app/app/data/models/token_model.dart.dart';
import 'package:notificaciones_unifront_app/app/data/provider/db_provider.dart';

class DbRepository {
  final _dbProvider = Get.find<DbProvider>();

  Future<TokenModel?> loginApoderado(
          {required String correo,
          required String password,
          required String token}) =>
      _dbProvider.loginApoderado(
          correo: correo, password: password, token: token);

  Future<TokenModel?> loginEstudiante(
          {required String correo,
          required String password,
          required String token}) =>
      _dbProvider.loginEstudiante(
          correo: correo, password: password, token: token);

  Future<TokenModel?> refresh({required String token}) =>
      _dbProvider.refresh(token: token);

  Future<bool> logOut({required String token}) =>
      _dbProvider.logOut(token: token);

  Future<EstudianteModel?> getEstudiantesForApoderado(
          {required String token}) =>
      _dbProvider.getEstudiantesForApoderado(token: token);

  Future<Estudiante?> getEstudiante({required String token}) =>
      _dbProvider.getEstudiante(token: token);

  Future<NotificacionModel?> getNotificaciones(
          {required String token, required String idEstudiante}) =>
      _dbProvider.getNotificaciones(token: token, idEstudiante: idEstudiante);

  Future<NotificacionModel?> getNotificacionesProx(
          {required String token, required String idEstudiante}) =>
      _dbProvider.getNotificacionesProx(
          token: token, idEstudiante: idEstudiante);
}
