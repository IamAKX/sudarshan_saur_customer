import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
            showPopup(context, DialogType.success, 'Success',
                'Your address is updated');
          },
          label: 'Validate and Update',
          isDisabled: false,
          isLoading: false,
        ),
        verticalGap(defaultPadding),
      ],
    );
  }
}
