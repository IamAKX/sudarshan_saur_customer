import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/theme.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_password_field_dark.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({
    Key? key,
    required this.passwordCtrl,
  }) : super(key: key);
  final TextEditingController passwordCtrl;

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'Enter new password',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        verticalGap(defaultPadding * 1.5),
        InputPasswordFieldDark(
            hint: 'Password',
            controller: widget.passwordCtrl,
            keyboardType: TextInputType.visiblePassword,
            icon: LineAwesomeIcons.user_lock),
        verticalGap(defaultPadding * 1.5),
      ],
    );
  }
}
