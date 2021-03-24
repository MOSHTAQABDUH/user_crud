import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_crud/app/data/model/user_model.dart';
import 'package:user_crud/app/data/repository/user_repository.dart';
import 'package:user_crud/app/routes/routes/app_routes.dart';

class LoginController extends GetxController {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController password2TextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  var dateS = ''.obs;
  DateTime date = DateTime.now();
  final data = GetStorage();

  final UserRepository repository = UserRepository();

  void register() async {
    UserModel user = await repository.createUser(UserModel(
        birthDate: date,
        email: emailTextController.text,
        password: passwordTextController.text,
        name: nameTextController.text));

    if (user != null) {
      Get.defaultDialog(title: 'Sucesso', content: Text('Usuario cadastrado'));
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.defaultDialog(title: 'Ops..', content: Text('Email já cadastrado'));
    }
    //passwordTextController.clear();
  }

  void login() async {
    UserModel user = await repository.loginWithEmail(
        emailTextController.text, passwordTextController.text);

    if (user != null) {
      data.write("user", user.toJson());
      Get.offNamed(Routes.HOME);
    } else {
      Get.defaultDialog(
          title: 'Ops..', content: Text('Email e/ou senha incorretos'));
    }
  }
}
