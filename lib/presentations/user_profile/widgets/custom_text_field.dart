import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String icon;
  final bool isPassword;
  final TextEditingController controller;
  final bool? isEnable;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.isPassword,
    required this.controller,
    this.isEnable,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnable ?? true,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Image.asset(
            icon,
            width: 16,
            height: 16,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
      ),
      onTapOutside: (e) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
