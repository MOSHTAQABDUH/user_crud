import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:user_crud/app/data/model/user_model.dart';
import 'package:user_crud/app/routes/routes/app_routes.dart';

class AuthController extends GetxService {
  RxString hash = "".obs;

  RxBool isLogged = false.obs;

  var myUser = UserModel().obs;
  GetStorage box = GetStorage();

  Future<void> logout() async {
    box.remove("user");

    myUser(UserModel());
    isLogged(false);
    Get.offNamedUntil(Routes.LOGIN, (_) => false);
  }

  void setPersistence({
    @required UserModel user,
  }) {
    myUser(user);
    isLogged(true);
  }

  Future<UserModel> getStorageUserModel() async {
    return UserModel.fromJson(box.read("user"));
  }

  Future<void> writeUser(UserModel _user) async {
    await box.write("user", _user.toJson());
  }

  Future<void> getHash() async {
    hash(await box.read("hash"));
  }

  Future<void> setHash(String _hash) async {
    hash(_hash);
    box.write("hash", _hash);
  }
}
