import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notificaciones_unifront_app/app/data/services/local_not_service.dart';

class FcmService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String?> getToken() async {
    final token = await messaging.getToken();
    return token;
  }

  Future<void> initNotificaciones() async {
    await requestPermission();
    FirebaseMessaging.onMessage.listen((event) {
      final title = event.notification?.title;
      final body = event.notification?.body;
      //debugPrint('onMessage $title $body');
      NotificationService().showNotifications(title ?? '', body ?? '');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final title = event.notification?.title;
      final body = event.notification?.body;
      //debugPrint('onMessageOpenedApp $title $body');
      //NotificationService().showNotifications(title ?? '', body ?? '');
    });
  }

  Future<bool> requestPermission() async {
    final status = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    switch (status.authorizationStatus) {
      case AuthorizationStatus.authorized:
        return true;
      case AuthorizationStatus.denied:
        return false;
      case AuthorizationStatus.notDetermined:
        return false;
      case AuthorizationStatus.provisional:
        return true;
    }
  }
}
