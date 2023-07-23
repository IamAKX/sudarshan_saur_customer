import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/user_model.dart';
import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/preference_key.dart';
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

  late ApiProvider _api;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    await _api
        .getCustomerById(prefs.getInt(SharedpreferenceKey.userId) ?? -1)
        .then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
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
            if (_password.text.isEmpty) {
              SnackBarService.instance
                  .showSnackBarError('All fields are mandatory');
              return;
            }
            if (_password.text.length < 8) {
              SnackBarService.instance
                  .showSnackBarError('Password must be of atleast 8 charaters');
              return;
            }

            Map<String, dynamic> map = {
              "password": base64.encode(_password.text.codeUnits)
            };
            _api.updateUser(map, user?.customerId ?? -1).then((value) async {
              if (value) {
                showPopup(context, DialogType.success, 'Success',
                    'Your password is updated');
              }
            });
          },
          label: 'Validate and Update',
          isDisabled: _api.status == ApiStatus.loading,
          isLoading: _api.status == ApiStatus.loading,
        )
      ],
    );
  }
}
