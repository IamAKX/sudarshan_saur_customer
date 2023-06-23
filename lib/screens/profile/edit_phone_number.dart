import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:saur_customer/utils/colors.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:saur_customer/widgets/alert_popup.dart';
import 'package:saur_customer/widgets/gaps.dart';
import 'package:saur_customer/widgets/input_field_light.dart';
import 'package:saur_customer/widgets/primary_button_dark.dart';

class EditPhoneNumber extends StatefulWidget {
  const EditPhoneNumber({super.key});

  @override
  State<EditPhoneNumber> createState() => _EditPhoneNumberState();
}

class _EditPhoneNumberState extends State<EditPhoneNumber> {
  final TextEditingController _phoneNumberCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();

  Timer? _timer;
  static const int otpResendThreshold = 10;
  int _secondsRemaining = otpResendThreshold;
  bool _timerActive = false;
  bool _isValidateButtonActive = true;

  void startTimer() {
    _secondsRemaining = otpResendThreshold;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          _timerActive = true;
        } else {
          _timer?.cancel();
          _timerActive = false;
        }
      });
    });
  }

  @override
  void dispose() {
    if (_timer != null) _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(defaultPadding),
        children: [
          verticalGap(defaultPadding),
          const Text(
            'Enter new phone number',
          ),
          verticalGap(defaultPadding),
          InputFieldLight(
              hint: 'Phone Number',
              controller: _phoneNumberCtrl,
              keyboardType: TextInputType.phone,
              obscure: false,
              icon: Icons.call_outlined),
          Align(
            alignment: Alignment.centerRight,
            child: _timerActive
                ? TextButton(
                    onPressed: null,
                    child: Text('Resend in $_secondsRemaining seconds'),
                  )
                : TextButton(
                    onPressed: () {
                      _isValidateButtonActive = false;
                      startTimer();
                    },
                    child: Text(
                      'Send OTP',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: primaryColor),
                    ),
                  ),
          ),
          verticalGap(defaultPadding * 2),
          const Text(
            'Enter the OTP',
          ),
          verticalGap(defaultPadding),
          OTPTextField(
            length: 4,
            width: MediaQuery.of(context).size.width - (defaultPadding * 3),
            fieldWidth: 40,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: textColorDark),
            otpFieldStyle: OtpFieldStyle(
              enabledBorderColor: primaryColor,
              borderColor: hintColor,
              focusBorderColor: primaryColor,
            ),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (pin) {
              _otpCtrl.text = pin;
            },
          ),
          verticalGap(defaultPadding * 2),
          PrimaryButtonDark(
            onPressed: () {
              showPopup(context, DialogType.success, 'Success',
                  'Your phone number is updated');
            },
            label: 'Validate and Update',
            isDisabled: _isValidateButtonActive,
            isLoading: false,
          )
        ],
      ),
    );
  }
}
