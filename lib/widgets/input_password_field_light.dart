import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class InputPasswordFieldLight extends StatefulWidget {
  const InputPasswordFieldLight(
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
  State<InputPasswordFieldLight> createState() => _InputPasswordFieldLightState();
}

class _InputPasswordFieldLightState extends State<InputPasswordFieldLight> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enabled ?? true,
      keyboardType: widget.keyboardType,
      autocorrect: true,
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: Icon(
          widget.icon,
        ),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? LineAwesomeIcons.eye : LineAwesomeIcons.eye_slash,
          ),
        ),
        alignLabelWithHint: true,
        filled: true,
      ),
    );
  }
}
