import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_crud/app/global/widgets/renew_hash.dart';
import 'package:user_crud/app/modules/home/controllers/home_controller.dart';
import 'package:oktoast/oktoast.dart';
import 'package:user_crud/app/routes/routes/app_routes.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage')),
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
        child: GetX<HomeController>(
            init: HomeController(),
            builder: (_) {
              try {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _.usersList.length,
                    itemBuilder: (context, index) => ListTile(
                        isThreeLine: false,
                        title: Text(_.usersList[index].name,
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text(
                            "Email: ${controller.usersList[index].email} \nData de Aniversário: ${controller.usersList[index].birthDate}",
                            style: TextStyle(fontSize: 10)),
                        trailing: Container(
                            width: 120,
                            child: Row(children: [
                              IconButton(
                                  icon: Icon(Icons.edit),
                                  color: Colors.lightBlue,
                                  onPressed: () {
                                    Get.toNamed(Routes.SIGNUP,
                                        arguments: controller.usersList[index]);
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _
                                        .deleteUser(_.usersList[index].id)
                                        .then((success) {
                                      if (success == false) {
                                        showToast(
                                            "Erro ao tentar deletar usuario!",
                                            backgroundColor: Colors.red[600]);
                                      }
                                    });
                                  })
                            ]))));
              } catch (e) {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
