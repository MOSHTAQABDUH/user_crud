import 'package:get/get.dart';

import 'package:user_crud/app/modules/login/controllers/login_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
