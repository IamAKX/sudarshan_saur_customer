import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:saur_customer/widgets/gaps.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification(
      {super.key,
      required this.phoneCtrl,
      required this.otpCode,
      required this.otpCodeCtrl});
  final TextEditingController phoneCtrl;
  final TextEditingController otpCodeCtrl;
  final String otpCode;

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'We have send an OTP on phone number ${widget.phoneCtrl.text}. Please enter the OTP to verify your phone number.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        verticalGap(defaultPadding * 2),
        OTPTextField(
          length: 4,
          width: MediaQuery.of(context).size.width - (defaultPadding * 3),
          fieldWidth: 40,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
              ),
          otpFieldStyle: OtpFieldStyle(
            enabledBorderColor: Colors.white54,
            borderColor: Colors.white54,
            focusBorderColor: Colors.white,
          ),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.underline,
          onCompleted: (pin) {
            widget.otpCodeCtrl.text = pin;
          },
        ),
      ],
    );
  }
}
