import 'package:user_crud/app/modules/login/bindings/login_binding.dart';
import 'package:user_crud/app/modules/login/views/login_page.dart';
import 'package:user_crud/app/modules/singup/bindings/signup_binding.dart';
import 'package:user_crud/app/modules/singup/views/signup_page.dart';
import 'package:user_crud/app/routes/routes/app_routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    /* GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),*/
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
    ),
  ];
}
