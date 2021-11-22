import 'package:get/get.dart';
import 'package:notificaciones_unifront_app/app/data/middlewares/auth_middleware.dart';
import 'package:notificaciones_unifront_app/app/modules/home/home_binding.dart';
import 'package:notificaciones_unifront_app/app/modules/home/home_view.dart';
import 'package:notificaciones_unifront_app/app/modules/inbox/inbox_binding.dart';
import 'package:notificaciones_unifront_app/app/modules/inbox/inbox_view.dart';
import 'package:notificaciones_unifront_app/app/modules/login/login_binding.dart';
import 'package:notificaciones_unifront_app/app/modules/login/login_view.dart';
import 'package:notificaciones_unifront_app/app/modules/next_pending/next_pending_binding.dart';
import 'package:notificaciones_unifront_app/app/modules/next_pending/next_pending_view.dart';
import 'package:notificaciones_unifront_app/app/modules/root/root_binding.dart';
import 'package:notificaciones_unifront_app/app/modules/root/root_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
        name: '/',
        page: () => RootPage(),
        binding: RootBinding(),
        participatesInRootNavigator: true,
        preventDuplicates: true,
        children: [
          GetPage(
            middlewares: [EnsureNotAuthMiddleware()],
            preventDuplicates: true,
            name: _Paths.login,
            page: () => LoginPage(),
            binding: LoginBinding(),
          ),
          GetPage(
              middlewares: [EnsureAuthMiddleware()],
              preventDuplicates: true,
              name: _Paths.home,
              page: () => HomePage(),
              binding: HomeBinding(),
              children: [
                GetPage(
                  preventDuplicates: true,
                  name: _Paths.inbox,
                  transition: Transition.zoom,
                  page: () => InboxPage(),
                  binding: InboxBinding(),
                ),
                GetPage(
                  preventDuplicates: true,
                  name: _Paths.nextPending,
                  transition: Transition.zoom,
                  page: () => NextPendingPage(),
                  binding: NextPendingBinding(),
                ),
              ]),
        ])
  ];
}
