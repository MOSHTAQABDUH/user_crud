import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String title;
  CustomButton(this.title, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Get.theme.primaryColor,
                Get.theme.primaryColor,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
