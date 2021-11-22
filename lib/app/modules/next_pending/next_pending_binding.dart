import 'package:get/get.dart';

import 'next_pending_logic.dart';

class NextPendingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NextPendingLogic());
  }
}
