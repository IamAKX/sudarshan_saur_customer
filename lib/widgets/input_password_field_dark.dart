import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class InputPasswordFieldDark extends StatefulWidget {
  const InputPasswordFieldDark(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.keyboardType,
      required this.icon,
      this.enabled})
      : super(key: key);

  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final IconData icon;

  final bool? enabled;

  @override
  State<InputPasswordFieldDark> createState() => _InputPasswordFieldDarkState();
}

class _InputPasswordFieldDarkState extends State<InputPasswordFieldDark> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enabled ?? true,
      keyboardType: widget.keyboardType,
      autocorrect: true,
      obscureText: _obscureText,
      controller: widget.controller,
      cursorColor: Colors.white,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: Icon(
          widget.icon,
          color: Colors.white70,
          size: 30,
        ),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? LineAwesomeIcons.eye : LineAwesomeIcons.eye_slash,
            color: Colors.white70,
            size: 25,
          ),
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
