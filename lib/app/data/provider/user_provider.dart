import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:user_crud/app/data/model/user_model.dart';

import 'package:user_crud/app/data/provider/auth.dart';
import 'package:get/get.dart' as Get;

class UserApiClient {
  AuthController auth = Get.Get.put(AuthController());

  Future<List<UserModel>> getUsers() async {
    try {
      print("https://crudcrud.com/api/${auth.hash}/usuarios");
      print(auth.hash);
      Response response =
          await Dio().get("https://crudcrud.com/api/${auth.hash}/usuarios");
      print(response);

      return UserModel.fromJsonList(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserModel> createUser({UserModel user}) async {
    try {
      print("https://crudcrud.com/api/${auth.hash}/usuarios");
      print(auth.hash);
      Map<String, dynamic> data = user.toJsonWithoutId();

      Response response = await Dio()
          .post("https://crudcrud.com/api/${auth.hash}/usuarios", data: data);

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
        "https://crudcrud.com/api/${auth.hash}/usuarios/$id",
      );
      print(response);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> emailExist(String _email) async {
    bool exist = false;
    return getUsers().then((users) {
      users.forEach((user) {
        if (user.email == _email) {
          exist = true;
        }
      });
    }).then((_) => exist);
  }

  Future<UserModel> loginWithEmail(String _email, String _senha) async {
    String md5senha = md5.convert(utf8.encode(_senha)).toString();
    UserModel _myUser = UserModel();
    return getUsers().then((users) {
      users.forEach((user) {
        if (user.email == _email) {
          if (user.password == md5senha) {
            //RECUPERAR HASH
            auth.getHash();
            //GRAVAR DADOS NO STORAGE
            auth.writeUser(user);
            //SETAR DADOS NO AUTH
            auth.setPersistence(user: user);
            _myUser = user;
          }
        }
      });
    }).then((_) => _myUser);
  }
}
