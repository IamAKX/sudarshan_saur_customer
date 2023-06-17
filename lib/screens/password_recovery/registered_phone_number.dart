import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/theme.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_field_dark.dart';

class RegisteredPhoneNumber extends StatefulWidget {
  const RegisteredPhoneNumber({super.key, required this.phoneCtrl});
  final TextEditingController phoneCtrl;

  @override
  State<RegisteredPhoneNumber> createState() => _RegisteredPhoneNumberState();
}

class _RegisteredPhoneNumberState extends State<RegisteredPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'Enter your registered phone number, linked to your account.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        verticalGap(defaultPadding * 1.5),
        InputFieldDark(
          hint: 'Phone',
          controller: widget.phoneCtrl,
          keyboardType: TextInputType.phone,
          obscure: false,
          icon: LineAwesomeIcons.phone,
        ),
        verticalGap(defaultPadding * 1.5),
      ],
    );
  }
}
