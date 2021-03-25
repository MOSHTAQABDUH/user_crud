import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextfield extends StatelessWidget {
  final bool obscureText;
  final Function validator;
  final TextEditingController controller;
  final String title;
  final IconData icon;
  CustomTextfield(
      {this.controller,
      this.icon,
      this.title,
      this.validator,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 1.2,
      height: Get.height * 0.07,
      padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextFormField(
        cursorColor: Colors.black,
        controller: controller,
        validator: validator,
        obscureText: obscureText == null ? false : obscureText,
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              icon,
              color: Get.theme.primaryColor,
            ),
            hintText: title,
            hintStyle: TextStyle(color: Colors.black)),
      ),
    );
  }
}
