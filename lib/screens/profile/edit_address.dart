// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/user_model.dart';
import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/preference_key.dart';
import '../../utils/theme.dart';
import '../../widgets/alert_popup.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_field_light.dart';
import '../../widgets/primary_button_dark.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({super.key});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final TextEditingController addressLine1Ctrl = TextEditingController();
  final TextEditingController addressLine2Ctrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController stateCtrl = TextEditingController();
  final TextEditingController zipCodeCtrl = TextEditingController();

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
        addressLine1Ctrl.text = user?.address?.addressLine1 ?? '';
        addressLine2Ctrl.text = user?.address?.addressLine2 ?? '';
        cityCtrl.text = user?.address?.city ?? '';
        stateCtrl.text = user?.address?.state ?? '';
        zipCodeCtrl.text = user?.address?.zipCode ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
    return ListView(
      padding: const EdgeInsets.all(defaultPadding),
      children: [
        verticalGap(defaultPadding),
        const Text(
          'Address',
        ),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'Address Line 1',
            controller: addressLine1Ctrl,
            keyboardType: TextInputType.streetAddress,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'Address Line 3',
            controller: addressLine2Ctrl,
            keyboardType: TextInputType.streetAddress,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'City',
            controller: cityCtrl,
            keyboardType: TextInputType.text,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'State',
            controller: stateCtrl,
            keyboardType: TextInputType.text,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'Zip Code',
            controller: zipCodeCtrl,
            keyboardType: TextInputType.number,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding * 2),
        PrimaryButtonDark(
          onPressed: () async {
            if (addressLine1Ctrl.text.isEmpty ||
                cityCtrl.text.isEmpty ||
                stateCtrl.text.isEmpty ||
                zipCodeCtrl.text.isEmpty) {
              SnackBarService.instance
                  .showSnackBarError('All fields are mandatory');
              return;
            }

            Map<String, dynamic> map = {
              "address": {
                "addressLine1": addressLine1Ctrl.text,
                "addressLine2": addressLine2Ctrl.text,
                "city": cityCtrl.text,
                "state": stateCtrl.text,
                "country": "India",
                "zipCode": zipCodeCtrl.text
              }
            };
            await _api
                .updateUser(map, user?.customerId ?? -1)
                .then((value) async {
              if (value) {
                await reloadScreen();
                showPopup(context, DialogType.success, 'Success',
                    'Your address is updated');
              }
            });
          },
          label: 'Validate and Update',
          isDisabled: _api.status == ApiStatus.loading,
          isLoading: _api.status == ApiStatus.loading,
        ),
        verticalGap(defaultPadding),
      ],
    );
  }
}
