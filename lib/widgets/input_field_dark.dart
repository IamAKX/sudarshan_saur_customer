import 'package:flutter/material.dart';

class InputFieldDark extends StatelessWidget {
  const InputFieldDark(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.keyboardType,
      required this.obscure,
      required this.icon,
      this.maxChar,
      this.enabled})
      : super(key: key);

  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscure;
  final IconData icon;
  final int? maxChar;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled ?? true,
      keyboardType: keyboardType,
      autocorrect: true,
      obscureText: obscure,
      maxLength: maxChar,
      controller: controller,
      cursorColor: Colors.white,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: Colors.white70,
          size: 30,
        ),
        alignLabelWithHint: true,
        filled: false,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white70),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
