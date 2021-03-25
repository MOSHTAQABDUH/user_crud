import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_crud/app/data/provider/auth.dart';
import 'package:user_crud/app/global/widgets/customButton.dart';
import 'package:user_crud/app/global/widgets/renew_hash.dart';
import 'package:user_crud/app/modules/home/home_controller.dart';
import 'package:intl/intl.dart';

import 'package:user_crud/app/routes/routes/app_routes.dart';

class HomePage extends GetView<HomeController> {
  final AuthController auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários'),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: auth.logout)],
      ),
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8),
            child: CustomButton(
              'Novo Usuário',
              onTap: () {
                Get.toNamed(Routes.SIGNUP);
              },
            ),
          ),
          Container(
            child: GetX<HomeController>(
              init: HomeController(),
              builder: (_) {
                try {
                  return _.usersList.length != 0
                      ? Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: _.usersList.length,
                              itemBuilder: (context, index) => ListTile(
                                  isThreeLine: false,
                                  title: Text(_.usersList[index].name,
                                      style: TextStyle(fontSize: 20)),
                                  subtitle: Text(
                                      "Email: ${_.usersList[index].email} \nData de Aniversário: ${(DateFormat(DateFormat.YEAR_MONTH_DAY, "pt_Br").format(_.usersList[index].birthDate))}",
                                      style: TextStyle(fontSize: 10)),
                                  trailing: Container(
                                      width: 120,
                                      child: Row(children: [
                                        IconButton(
                                            icon: Icon(Icons.edit),
                                            color: Colors.lightBlue,
                                            onPressed: () {
                                              Get.toNamed(Routes.SIGNUP,
                                                  arguments: index);
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              _
                                                  .deleteUser(index)
                                                  .then((success) {
                                                if (success == false) {
                                                  Get.defaultDialog(
                                                      title: "Ops..",
                                                      content: Text(
                                                          "Erro ao tentar deletar usuario!"));
                                                }
                                              });
                                            })
                                      ])))),
                        )
                      : Container(
                          height: Get.height * 0.1,
                          child: CircularProgressIndicator());
                } catch (e) {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
