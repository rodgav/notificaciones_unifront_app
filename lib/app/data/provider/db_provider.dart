import 'dart:convert';

import 'package:notificaciones_unifront_app/app/core/utils/helpers/http/http.dart';
import 'package:notificaciones_unifront_app/app/data/models/estudiante_model.dart';
import 'package:notificaciones_unifront_app/app/data/models/notificaciones_model.dart';
import 'package:notificaciones_unifront_app/app/data/models/token_model.dart.dart';

class DbProvider {
  final Http _http;

  DbProvider(this._http);

  Future<TokenModel?> loginApoderado(
      {required String correo, required String password}) async {
    try {
      final json = {'correo': correo, 'password': password};
      final result = await _http.request('loginApoderado',
          method: HttpMethod.post, body: {'json': jsonEncode(json)});
      return TokenModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<TokenModel?> loginEstudiante(
      {required String correo, required String password}) async {
    try {
      final json = {'correo': correo, 'password': password};
      final result = await _http.request('loginEstudiante',
          method: HttpMethod.post, body: {'json': jsonEncode(json)});
      return TokenModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<TokenModel?> refresh({required String token}) async {
    try {
      final result = await _http.request('refresh',
          method: HttpMethod.post, headers: {'Authorization': token});
      return TokenModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<bool> logOut({required String token}) async {
    try {
      final result = await _http.request('logOut',
          method: HttpMethod.post, headers: {'Authorization': token});
      final data = result.data as Map<String, dynamic>;
      if (data['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<EstudianteModel?> getEstudiantesForApoderado(
      {required String token}) async {
    try {
      final result = await _http.request('estudiantesForApoderado',
          method: HttpMethod.get, headers: {'Authorization': token});
      return EstudianteModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<NotificacionModel?> getNotificaciones(
      {required String token, required String idEstudiante}) async {
    try {
      final result = await _http.request('notificaciones',
          method: HttpMethod.get,
          headers: {'Authorization': token},
          queryParameters: {'idEstudiante': idEstudiante});
      return NotificacionModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<NotificacionModel?> getNotificacionesProx(
      {required String token, required String idEstudiante}) async {
    try {
      final result = await _http.request('notificacionesProx',
          method: HttpMethod.get,
          headers: {'Authorization': token},
          queryParameters: {'idEstudiante': idEstudiante});
      return NotificacionModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }
}
