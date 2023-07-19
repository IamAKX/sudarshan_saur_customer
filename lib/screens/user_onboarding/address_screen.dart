import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:saur_customer/widgets/input_field_dark.dart';

import '../../utils/theme.dart';
import '../../widgets/gaps.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen(
      {super.key,
      required this.addressLine1Ctrl,
      required this.addressLine2Ctrl,
      required this.cityCtrl,
      required this.stateCtrl,
      required this.zipCodeCtrl});

  final TextEditingController addressLine1Ctrl;
  final TextEditingController addressLine2Ctrl;
  final TextEditingController cityCtrl;
  final TextEditingController stateCtrl;
  final TextEditingController zipCodeCtrl;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InputFieldDark(
          hint: 'Address Line 1',
          controller: widget.addressLine1Ctrl,
          keyboardType: TextInputType.streetAddress,
          obscure: false,
          icon: LineAwesomeIcons.home,
        ),
        verticalGap(defaultPadding * 1.5),
        InputFieldDark(
          hint: 'Address Line 2',
          controller: widget.addressLine2Ctrl,
          keyboardType: TextInputType.streetAddress,
          obscure: false,
          icon: LineAwesomeIcons.home,
        ),
        verticalGap(defaultPadding * 1.5),
        InputFieldDark(
          hint: 'City',
          controller: widget.cityCtrl,
          keyboardType: TextInputType.text,
          obscure: false,
          icon: LineAwesomeIcons.home,
        ),
        verticalGap(defaultPadding * 1.5),
        InputFieldDark(
          hint: 'State',
          controller: widget.stateCtrl,
          keyboardType: TextInputType.text,
          obscure: false,
          icon: LineAwesomeIcons.home,
        ),
        verticalGap(defaultPadding * 1.5),
        InputFieldDark(
          hint: 'Zip code',
          controller: widget.zipCodeCtrl,
          keyboardType: TextInputType.number,
          obscure: false,
          icon: LineAwesomeIcons.home,
        ),
        verticalGap(defaultPadding * 1.5),
      ],
    );
  }
}
