import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.controller,
      this.validator,
      this.maxLines = 1,
      this.keyboardType = TextInputType.text,
      this.obscureText = false});
  final String hintText, labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          cursorColor: Colors.black,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(30, 0, 0, 255),
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            alignLabelWithHint: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          validator: validator,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
