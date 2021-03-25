import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_crud/app/data/model/user_model.dart';
import 'package:user_crud/app/data/provider/auth.dart';
import 'package:user_crud/app/data/repository/user_repository.dart';
import 'package:user_crud/app/modules/home/home_controller.dart';
import 'package:user_crud/app/routes/routes/app_routes.dart';

class SignUpController extends GetxController {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController password2TextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();

  final AuthController _auth = Get.put(AuthController());
  final UserRepository repository = UserRepository();
  int index;
  HomeController _homeController;
  UserModel user;
  var dateS = ''.obs;
  DateTime date = DateTime.now();
  var isEditing = false.obs; //true para edicao false para criacao novo usuario
  final data = GetStorage();

  @override
  void onInit() {
    if (_auth.isLogged.value) {
      _homeController = Get.put(HomeController());
      if (Get.arguments != null) {
        index = Get.arguments;
        user = _homeController.usersList[index];

        print(index);
        emailTextController.text = user.email;
        nameTextController.text = user.name;
        dateS(DateFormat(DateFormat.YEAR_MONTH_DAY, "pt_Br")
            .format(user.birthDate));
        isEditing(true);
      }
    }

    super.onInit();
  }

  void clearControllers() {
    emailTextController.clear();
    passwordTextController.clear();
    password2TextController.clear();
    nameTextController.clear();
  }

  void edit() async {
    bool isEditingEmail = false;
    bool hasEmail = false;
    if (user.email != emailTextController.text) {
      isEditingEmail = true;
    }
    if (!isEditingEmail) {
      //edicao sem alteracao de email
      UserModel user = await repository.updateUser(UserModel(
          id: this.user.id,
          birthDate: date,
          email: emailTextController.text,
          password: passwordTextController.text,
          name: nameTextController.text));

      if (user != null) {
        Get.back();
        _homeController.usersList[Get.arguments] = user;
        _homeController.usersList.refresh();
        Get.defaultDialog(title: 'Sucesso', content: Text('Usuario editado'));
        clearControllers();
      } else {
        Get.defaultDialog(title: 'Ops', content: Text('Erro na requisição!'));
      }
    } else {
      //esta editando o email
      hasEmail = await repository.emailExist(emailTextController.text);
      if (hasEmail) {
        //edicao com email já cadastrado
        Get.defaultDialog(title: 'Ops..', content: Text('Email já cadastrado'));
      } else {
        //edicao com alteracao de email nao cadastrado
        UserModel userResponse = await repository.updateUser(UserModel(
            id: this.user.id,
            birthDate: date,
            email: emailTextController.text,
            password: passwordTextController.text,
            name: nameTextController.text));
        Get.back();
        Get.defaultDialog(title: 'Sucesso', content: Text('Usuario editado'));
        clearControllers();

        _homeController.usersList[index] = userResponse;
        _homeController.usersList.refresh();
      }
    }
  }

  void register() async {
    bool hasEmail = false;
    hasEmail = await repository.emailExist(emailTextController.text);
    if (!hasEmail) {
      UserModel userResponse = await repository.createUser(UserModel(
          birthDate: date,
          email: emailTextController.text,
          password: passwordTextController.text,
          name: nameTextController.text));

      if (userResponse != null) {
        if (!_auth.isLogged.value) {
          clearControllers();
          Get.offAllNamed(Routes.LOGIN);
          Get.defaultDialog(
              title: 'Sucesso', content: Text('Usuario cadastrado'));
        } else {
          Get.back();
          Get.defaultDialog(
              title: 'Sucesso', content: Text('Usuario cadastrado'));
          clearControllers();
          _homeController.usersList.add(userResponse);
        }
      } else {
        Get.defaultDialog(title: 'Ops', content: Text('Erro na requisição!'));
      }
    } else {
      Get.defaultDialog(title: 'Ops..', content: Text('Email já cadastrado'));
    }
  }
}
