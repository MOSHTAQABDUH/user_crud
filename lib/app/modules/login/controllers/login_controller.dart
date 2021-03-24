import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController password2TextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  var dateS = ''.obs;
  DateTime date = DateTime.now();
  final data = GetStorage();

  void login() {}
  void register() {}
  /* final LoginRepository repository = LoginRepository();
  final ProfileRepository profileRepository = ProfileRepository();

  void register() async {
    User user = await repository.signUp(User(
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
    passwordTextController.clear();
  }

  void login() async {
    User user = await repository.login(
        emailTextController.text, passwordTextController.text);

    if (user != null) {
      Profile profile = await profileRepository.getFirstUserProfile(user.id);
      data.write("userId", user.id);
      data.write("profileId", profile.id);
      data.write("user", user.toMap());
      Get.offNamed(Routes.HOME);
    } else {
      Get.defaultDialog(
          title: 'Ops..', content: Text('Email e/ou senha incorretos'));
    }
  }*/
}
