part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const login = _Paths.login;

  static String loginThen(String afterSuccessFullLogin) =>
      '$login?then=${Uri.encodeQueryComponent(afterSuccessFullLogin)}';
  static const home = _Paths.home;

  static const inbox = '$home${_Paths.inbox}';
  static const nextPending = '$home${_Paths.nextPending}';
}

abstract class _Paths {
  static const login = '/login';
  static const home = '/home';

  static const inbox = '/inbox';
  static const nextPending = '/nextPending';
}
