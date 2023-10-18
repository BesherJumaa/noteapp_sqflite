import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final String? textBox;
  final String? hintText;
  final IconData? iconPrefix;
  final TextEditingController? mycontroller;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  AuthTextFormField({
    super.key,
    this.keyboardType,
    required this.textBox,
    required this.hintText,
    this.iconPrefix,
    this.mycontroller,
    this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 7),
                child: Text(textBox!)),
            hintStyle: const TextStyle(fontSize: 14),
            hintText: hintText,
            suffixIcon: Icon(iconPrefix),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            )),
      ),
    );
  }
}
