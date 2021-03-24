import 'package:user_crud/app/data/provider/user_provider.dart';

class UserRepository {
  final UserApiClient apiClient = UserApiClient();

  getUsers() {
    return apiClient.getUsers();
  }

  createUser(user) {
    return apiClient.createUser(user: user);
  }

  deleteUser(id) {
    return apiClient.deleteUser(id);
  }

  emailExist(email) {
    return apiClient.emailExist(email);
  }

  loginWithEmail(email, senha) {
    return apiClient.loginWithEmail(email, senha);
  }
}
