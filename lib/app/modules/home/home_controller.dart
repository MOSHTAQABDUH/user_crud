import 'package:get/get.dart';
import 'package:user_crud/app/data/model/user_model.dart';
import 'package:user_crud/app/data/repository/user_repository.dart';

class HomeController extends GetxController {
  final UserRepository repository = UserRepository();

  var usersList = <UserModel>[].obs;

  Future<bool> deleteUser(int index) async {
    bool deletedSucess = await repository.deleteUser(usersList[index].id);
    if (deletedSucess) {
      usersList.removeAt(index);
      return true;
    } else
      return false;
  }

  @override
  void onInit() async {
    usersList(await repository.getUsers());
    super.onInit();
  }
}
