import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificaciones_unifront_app/app/routes/app_pages.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.find<HomeLogic>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(builder: (context, delegate, current) {
      /*debugPrint('student ${ StudentService.to.estudiante}');*/
      final currentLocation = current?.location;
      var currentIndex = 0;
      if (currentLocation?.startsWith(Routes.nextPending) == true) {
        currentIndex = 1;
      }
      //debugPrint('title $currentLocation');
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            currentIndex == 0 ? 'Bandeja de entrada' : 'Próximos pendientes',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            GestureDetector(
                    child: const CircleAvatar(
                      backgroundColor: Color(0xffC4C4C4),
                      child: Icon(
                        Icons.person,
                        color: Color(0xff1E4280),
                      ),
                    ),
                    onTap: () => logic.onChangeStudent(currentLocation),
                  )
          ],
        ),
        body: GetRouterOutlet(
          initialRoute: Routes.inbox,
          key: Get.nestedKey(Routes.home),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color(0xff1E4280),
          currentIndex: currentIndex,
          onTap: (value) {
            switch (value) {
              case 0:
                delegate.toNamed(Routes.inbox);
                break;
              case 1:
                delegate.toNamed(Routes.nextPending);
                break;
              default:
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/home.png'),
                size: 24,
              ),
              label: 'Bandeja',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/nexts.png'),
                size: 24,
              ),
              label: 'Proximos',
            ),
          ],
        ),
      );
    });
  }
}
