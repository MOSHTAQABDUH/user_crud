import 'package:flutter/material.dart';
import 'package:user_crud/app/data/provider/auth.dart';
import 'package:get/get.dart';

class RenewHash extends StatelessWidget {
  TextEditingController hashController = TextEditingController();
  AuthController auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    hashController.text = auth.hash.value;
    return Center(
      child: Container(
        width: 300,
        height: 300,
        child: Card(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Text("Digite um novo Hash")),
                  TextFormField(
                    decoration: InputDecoration(labelText: "hash"),
                    controller: hashController,
                  ),
                  Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      onPressed: () {
                        auth.setHash(hashController.text);
                        Get.back();
                      },
                      child: Text("Salvar"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
