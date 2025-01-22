import 'package:flutter/material.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';

class BioskopTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isObscureText;

  const BioskopTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.isObscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: ghostWhite,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade800,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ghostWhite,
          ),
        ),
      ),
    );
  }
}
