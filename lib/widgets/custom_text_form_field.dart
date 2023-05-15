import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final bool obscureText;
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        cursorColor: Colors.black,
        controller: controller,
        obscureText: obscureText,
        validator: (value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          labelStyle: const TextStyle(color: Colors.black),
          hintStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black),
          ),
          prefixIconColor: Colors.black,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
