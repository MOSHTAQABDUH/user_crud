import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:user_crud/app/global/widgets/customButton.dart';
import 'package:user_crud/app/global/widgets/customTextField.dart';
import 'package:user_crud/app/global/widgets/renew_hash.dart';
import 'package:user_crud/app/modules/login/login_controller.dart';
import 'package:user_crud/app/routes/routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    void showPasswordChanger() {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              "Preencha os campos",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Container(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  onPressed: () {
                    if (_formKeyPassword.currentState.validate()) {
                      _loginController.changePassword();
                      Get.back();
                    }
                  },
                  child: Text(
                    "Salvar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
            content: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: double.maxFinite,
                  height: Get.height / 2,
                  child: Form(
                    key: _formKeyPassword,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CustomTextfield(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Campo obrigatorio";
                            } else if (!GetUtils.isEmail(value)) {
                              return "Email Inválido";
                            }
                            return null;
                          },
                          icon: Icons.email,
                          controller: _loginController.emailTextController,
                          title: 'Email',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        CustomTextfield(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Campo obrigatorio";
                            } else if (value.length < 6) {
                              return "Senha muito curta";
                            }
                            return null;
                          },
                          obscureText: true,
                          icon: Icons.vpn_key,
                          controller:
                              _loginController.oldPasswordTextController,
                          title: 'Senha Antiga',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        CustomTextfield(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Campo obrigatorio";
                            } else if (value.length < 6) {
                              return "Senha muito curta";
                            }
                            return null;
                          },
                          obscureText: true,
                          icon: Icons.vpn_key,
                          controller: _loginController.passwordTextController,
                          title: 'Nova Senha',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        CustomTextfield(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Campo obrigatorio";
                            } else if (!(value ==
                                _loginController.passwordTextController.text)) {
                              return "Senhas não são iguais";
                            }
                            return null;
                          },
                          obscureText: true,
                          icon: Icons.vpn_key,
                          controller: _loginController
                              .passwordConfirmationTextController,
                          title: 'Confirmar Nova Senha',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RenewHash();
                });
          },
          label: Text("Hash"),
          icon: Icon(Icons.playlist_add)),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                width: Get.width,
                height: Get.height / 3.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Get.theme.primaryColor,
                        Colors.white,
                      ], //Color(0xff6bceff)
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.person,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32, right: 32),
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: Get.height / 2,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    CustomTextfield(
                      title: 'Email',
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo obrigatorio";
                        } else if (!GetUtils.isEmail(value)) {
                          return "Email Inválido";
                        }
                        return null;
                      },
                      controller: _loginController.emailTextController,
                      icon: Icons.email,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    CustomTextfield(
                      obscureText: true,
                      title: 'Senha',
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo obrigatorio";
                        }
                        return null;
                      },
                      controller: _loginController.passwordTextController,
                      icon: Icons.vpn_key,
                    ),
                    InkWell(
                      onTap: showPasswordChanger,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 32),
                          child: Text(
                            'Trocar a Senha',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 32),
                          child: Text(
                            'Cadastrar',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.SIGNUP);
                      },
                    ),
                    Spacer(),
                    CustomButton(
                      'Entrar',
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          _loginController.login();
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
