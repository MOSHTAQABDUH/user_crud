import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user_crud/app/data/provider/auth.dart';
import 'package:user_crud/app/global/widgets/customButton.dart';
import 'package:user_crud/app/global/widgets/customTextField.dart';
import 'package:user_crud/app/global/widgets/renew_hash.dart';

import 'package:user_crud/app/modules/singup/signup_controller.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController _signUpController = Get.find<SignUpController>();
  final AuthController _auth = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    void showDatPicker() async {
      final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2150),
        locale: Localizations.localeOf(context),
      );
      if (date != null) {
        _signUpController.dateS.value =
            DateFormat(DateFormat.YEAR_MONTH_DAY, "pt_Br").format(date);

        _signUpController.date = date;
      }
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: Get.height,
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
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
                          ],
                        ),
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(90))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Get.back()),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: _auth.isLogged.value
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ),
                                      onPressed: _auth.logout)
                                  : SizedBox(),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            _signUpController.isEditing.value
                                ? Icons.edit
                                : Icons.person_add,
                            size: 90,
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 32, right: 32),
                            child: Text(
                              '',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        CustomTextfield(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Campo obrigatorio";
                            }
                            return null;
                          },
                          controller: _signUpController.nameTextController,
                          title: 'Nome',
                          icon: Icons.person,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
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
                          controller: _signUpController.emailTextController,
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
                          controller: _signUpController.passwordTextController,
                          title: 'Senha',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        CustomTextfield(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Campo obrigatorio";
                            } else if (!(value ==
                                _signUpController
                                    .passwordTextController.text)) {
                              return "Senhas não são iguais";
                            }
                            return null;
                          },
                          obscureText: true,
                          icon: Icons.vpn_key,
                          controller: _signUpController.password2TextController,
                          title: 'Confirmar Senha',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            showDatPicker();
                          },
                          child: Container(
                            height: Get.height * 0.07,
                            width: MediaQuery.of(context).size.width / 1.2,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white,
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    color: Colors.lightBlue,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.05,
                                  ),
                                  Obx(() => Text(
                                        _signUpController.dateS.value == ''
                                            ? 'Data Nascimento'.toUpperCase()
                                            : _signUpController.dateS.value,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CustomButton(
                          _signUpController.isEditing.value
                              ? 'Editar'
                              : 'Cadastrar',
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              if (_signUpController.isEditing.value) {
                                _signUpController.edit();
                              } else
                                _signUpController.register();
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
        ),
      ),
    );
  }
}
