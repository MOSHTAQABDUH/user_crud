import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:user_crud/app/data/model/user_model.dart';

import 'package:user_crud/app/data/provider/auth.dart';
import 'package:get/get.dart' as Get;
import 'package:user_crud/app/global/constants.dart';

class UserApiClient {
  AuthController auth = Get.Get.put(AuthController());

  Future<List<UserModel>> getUsers() async {
    try {
      print(auth.hash);
      Response response = await Dio().get(BASEURL + "${auth.hash}/usuarios");
      print(response);
      if (response.data.length != 0) {
        return UserModel.fromJsonList(response.data);
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  String getMd5(String password) {
    return md5.convert(utf8.encode(password)).toString();
  }

  Future<int> changePassword(
      {String oldPassword, String email, String newPassword}) async {
    var users = await getUsers();
    if (users == null) {
      //sem usuarios cadastrados
      return 0;
    } else {
      for (var user in users) {
        if (user.email == email) {
          //emails coincidem
          print(getMd5(oldPassword));
          if (user.password == getMd5(oldPassword)) {
            //senhas coincidem
            user.password = newPassword;
            var userResponse = await updateUser(user: user);
            if (userResponse != null) {
              return 1; //senha alterada com sucesso
            } else {
              return 0; //senha nao alterada
            }
          } else {
            return 2;
            //senhas nao coincidem
          }
        }
      }
      return 3; //email n encontrado
    }
  }

  Future<UserModel> createUser({UserModel user}) async {
    try {
      print(auth.hash);
      Map<String, dynamic> data = user.toJsonWithoutId();

      Response response =
          await Dio().post(BASEURL + "${auth.hash}/usuarios", data: data);

      print(response);

      if (response.data.length != 0) {
        return UserModel.fromJson(response.data);
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserModel> updateUser({UserModel user}) async {
    try {
      print(auth.hash);
      Map<String, dynamic> data = user.toJsonWithoutId();

      Response response = await Dio()
          .put(BASEURL + "${auth.hash}/usuarios/${user.id}", data: data);

      print(response);

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      print(auth.hash);
      Response response = await Dio().delete(
        BASEURL + "${auth.hash}/usuarios/$id",
      );
      print(response);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> emailExist(String _email) async {
    var users = await getUsers();
    if (users == null) {
      return false;
    } else {
      for (var user in users) {
        if (user.email == _email) {
          return true;
        }
      }
      return false;
    }
  }

  Future<UserModel> loginWithEmail(String _email, String _senha) async {
    String md5senha = getMd5(_senha);
    UserModel _myUser = UserModel();
    var users = await getUsers();
    if (users == null) {
      return null;
    } else {
      for (var user in users) {
        if (user.email == _email) {
          if (user.password == md5senha) {
            //RECUPERAR HASH
            auth.getHash();
            //GRAVAR DADOS NO STORAGE
            auth.writeUser(user);
            //SETAR DADOS NO AUTH
            auth.setPersistence(user: user);
            _myUser = user;
            return _myUser;
          }
        }
      }
      return null;
    }
  }
}
