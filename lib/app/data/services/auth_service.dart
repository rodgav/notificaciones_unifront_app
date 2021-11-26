import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:notificaciones_unifront_app/app/data/models/token_model.dart.dart';
import 'package:notificaciones_unifront_app/app/data/repositorys/db_repository.dart';

class AuthService extends GetxService {

  static AuthService get to => Get.find();

  final _dbRepository = Get.find<DbRepository>();
  final _getStorage = GetStorage();

  String? get jwt => _getStorage.read('jwt');

  String? get role => _getStorage.read('role');

  String? get sub => _getStorage.read('sub').toString();

  Future<void> saveSession(TokenModel tokenModel, String role) async {
    Map<String, dynamic> payload = Jwt.parseJwt(tokenModel.jwt!);
    await _getStorage.write('role', role);
    await _getStorage.write('sub', payload['sub'] ?? '');
    await _getStorage.write('correo', payload['correo'] ?? '');
    await _getStorage.write('jwt', tokenModel.jwt);
    await _getStorage.write(
        'createdAt',
        DateTime.fromMillisecondsSinceEpoch(payload['iat'] * 1000, isUtc: true)
            .toString());
    await _getStorage.write(
        'expiresIn',
        DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000, isUtc: true)
            .toString());
  }

  Future<bool> eraseSession({bool server = true}) async {
    final token = await _getStorage.read('jwt') ?? '';
    if (server) {
      final logOut = await _dbRepository.logOut(token: token);
      if (logOut) {
        await _getStorage.erase();
        return true;
      }else{
        return false;
      }
    } else {
      await _getStorage.erase();
      return true;
    }
  }

  Future<String?> getToken() async {
    final token = await _getStorage.read('jwt') ?? '';
    final role = await _getStorage.read('role') ?? '';
    if (token != '') {
      final expiresIn = await _getStorage.read('expiresIn') ?? '';
      final expires = DateTime.parse(expiresIn);
      if (DateTime.now().isBefore(expires)) {
        return token;
      }
      final tokenModel = await _dbRepository.refresh(token: token);
      if (tokenModel != null && tokenModel.jwt != null) {
        debugPrint('ingreso aqui');
        await saveSession(tokenModel, role);
        return tokenModel.jwt;
      } else {
        await eraseSession();
      }
      return null;
    } else {
      return null;
    }
  }
}
