import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_crud/app/data/model/user_model.dart';
import 'package:user_crud/app/data/repository/user_repository.dart';
import 'package:user_crud/app/routes/routes/app_routes.dart';

class LoginController extends GetxController {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController oldPasswordTextController =
      TextEditingController();
  final TextEditingController passwordConfirmationTextController =
      TextEditingController();

  final data = GetStorage();

  final UserRepository repository = UserRepository();

  void clearControllers() {
    emailTextController.clear();
    passwordTextController.clear();
  }

  void changePassword() async {
    int sucess = await repository.changePassword(
        email: emailTextController.text,
        newPassword: passwordTextController.text,
        oldPassword: oldPasswordTextController.text);
    switch (sucess) {
      case 0:
        Get.defaultDialog(
            title: 'Ops', content: Text('Não foi possivel alterar sua senha'));
        break;
      case 1:
        Get.defaultDialog(
            title: 'Sucesso', content: Text('Senha alterado com sucesso!'));
        break;
      case 2:
        Get.defaultDialog(
            title: 'Ops', content: Text('Senha anterior nao coincide'));
        break;
      case 3:
        Get.defaultDialog(title: 'Ops', content: Text('Email nao encontrado'));
        break;
      default:
    }
  }

  void login() async {
    UserModel user = await repository.loginWithEmail(
        emailTextController.text, passwordTextController.text);

    if (user != null) {
      data.write("user", user.toJson());
      clearControllers();
      Get.offNamed(Routes.HOME);
    } else {
      Get.defaultDialog(
          title: 'Ops..', content: Text('Email e/ou senha incorretos'));
    }
  }
}
