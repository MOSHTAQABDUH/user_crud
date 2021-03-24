import 'package:get/get.dart';
import 'package:user_crud/app/data/model/user_model.dart';
import 'package:user_crud/app/data/repository/user_repository.dart';

class HomeController extends GetxController {
  final UserRepository repository = UserRepository();

  var usersList = <UserModel>[].obs;

  Future<bool> deleteUser(String id) {}

  @override
  void onInit() async {
    usersList(await repository.getUsers());
    super.onInit();
  }
}
