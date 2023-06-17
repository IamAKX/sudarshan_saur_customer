import 'package:flutter/material.dart';
import 'package:saur_customer/screens/user_onboarding/otp_verification.dart';
import 'package:saur_customer/screens/user_onboarding/user_detail.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:saur_customer/widgets/gaps.dart';
import 'package:saur_customer/widgets/primary_button.dart';

import '../../utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routePath = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _otpCodeCtrl = TextEditingController();
  int step = 1;

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
                  'New\nAccount 🙋🏼‍♂️',
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
                          '/2',
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
            Expanded(
              child: step == 1
                  ? UserDetail(
                      emailCtrl: _emailCtrl,
                      passwordCtrl: _passwordCtrl,
                      phoneCtrl: _phoneCtrl,
                      nameCtrl: _nameCtrl)
                  : OtpVerification(
                      phoneCtrl: _phoneCtrl,
                      otpCode: '1234',
                      otpCodeCtrl: _otpCodeCtrl,
                    ),
            ),
            verticalGap(defaultPadding * 1.5),
            Row(
              children: [
                Visibility(
                  visible: step == 2,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        step = 1;
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
                  visible: step == 1,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        step = 2;
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
                  visible: step == 2,
                  child: SizedBox(
                    width: 250,
                    child: PrimaryButton(
                        onPressed: () {
                          print(_otpCodeCtrl.text);
                        },
                        label: 'Register',
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
}
