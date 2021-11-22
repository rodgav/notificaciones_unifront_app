import 'package:get/get.dart';

import 'inbox_logic.dart';

class InboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InboxLogic());
  }
}
