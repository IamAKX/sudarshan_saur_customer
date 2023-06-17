import 'package:flutter/material.dart';
import 'package:saur_customer/screens/password_recovery/new_password.dart';
import 'package:saur_customer/screens/password_recovery/registered_phone_number.dart';
import 'package:saur_customer/screens/user_onboarding/otp_verification.dart';

import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../../widgets/gaps.dart';
import '../../widgets/primary_button.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});
  static const String routePath = '/recoverPassword';

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _otpCodeCtrl = TextEditingController();
  int step = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            blueGradientDark,
            blueGradientLight,
          ],
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 1.5,
          vertical: defaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalGap(defaultPadding * 1.5),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            verticalGap(defaultPadding),
            Row(
              children: [
                Text(
                  'Password\nForgotten 🙆🏼‍♂️',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$step',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          '/3',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                    Text(
                      'STEPS',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            verticalGap(defaultPadding * 1.5),
            Expanded(child: getCurrentStepWidget()),
            verticalGap(defaultPadding * 1.5),
            Row(
              children: [
                Visibility(
                  visible: (step == 3 || step == 2),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        step -= 1;
                      });
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: (step == 1 || step == 2),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        step += 1;
                      });
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: step == 3,
                  child: SizedBox(
                    width: 250,
                    child: PrimaryButton(
                        onPressed: () {
                          print(_otpCodeCtrl.text);
                        },
                        label: 'Change',
                        isDisabled: false,
                        isLoading: false),
                  ),
                ),
              ],
            ),
            verticalGap(defaultPadding),
          ],
        ),
      ),
    );
  }

  getCurrentStepWidget() {
    switch (step) {
      case 1:
        return RegisteredPhoneNumber(phoneCtrl: _phoneCtrl);
      case 2:
        return OtpVerification(
            phoneCtrl: _phoneCtrl, otpCode: '1234', otpCodeCtrl: _otpCodeCtrl);
      case 3:
        return NewPassword(passwordCtrl: _passwordCtrl);
      default:
        return Container();
    }
  }
}
