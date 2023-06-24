import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../utils/theme.dart';
import '../../widgets/alert_popup.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_password_field_light.dart';
import '../../widgets/primary_button_dark.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
  static const String routePath = '/changePassword';

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Change Password',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: getBody(context));
  }

  getBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(defaultPadding),
      children: [
        verticalGap(defaultPadding),
        const Text(
          'Enter new password',
        ),
        verticalGap(defaultPadding),
        InputPasswordFieldLight(
            hint: 'Password',
            controller: _password,
            keyboardType: TextInputType.visiblePassword,
            icon: Icons.call_outlined),
        verticalGap(defaultPadding * 2),
        PrimaryButtonDark(
          onPressed: () {
            showPopup(context, DialogType.success, 'Success',
                'Your password is updated');
          },
          label: 'Validate and Update',
          isDisabled: false,
          isLoading: false,
        )
      ],
    );
  }
}
