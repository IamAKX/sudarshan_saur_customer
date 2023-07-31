import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:saur_customer/screens/user_onboarding/agreement_screen.dart';
import 'package:saur_customer/screens/user_onboarding/register_screen.dart';
import 'package:saur_customer/utils/colors.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:saur_customer/widgets/gaps.dart';
import 'package:saur_customer/widgets/input_password_field_dark.dart';

import '../../widgets/input_field_dark.dart';

class UserDetail extends StatefulWidget {
  const UserDetail(
      {super.key,
      required this.emailCtrl,
      required this.passwordCtrl,
      required this.phoneCtrl,
      required this.nameCtrl});
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController nameCtrl;

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InputFieldDark(
          hint: 'Full Name',
          controller: widget.nameCtrl,
          keyboardType: TextInputType.name,
          obscure: false,
          icon: LineAwesomeIcons.user,
        ),
        verticalGap(defaultPadding * 1.5),
        InputFieldDark(
          hint: 'Email',
          controller: widget.emailCtrl,
          keyboardType: TextInputType.emailAddress,
          obscure: false,
          icon: LineAwesomeIcons.at,
        ),
        verticalGap(defaultPadding * 1.5),
        InputPasswordFieldDark(
            hint: 'Password',
            controller: widget.passwordCtrl,
            keyboardType: TextInputType.visiblePassword,
            icon: LineAwesomeIcons.user_lock),
        verticalGap(defaultPadding * 1.5),
        InputFieldDark(
          hint: 'Phone',
          controller: widget.phoneCtrl,
          keyboardType: TextInputType.phone,
          obscure: false,
          icon: LineAwesomeIcons.phone,
        ),
        verticalGap(defaultPadding * 1.5),
        Row(
          children: [
            Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  side: const BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              child: Checkbox(
                activeColor: Colors.white,
                checkColor: primaryColor,
                value: RegisterScreen.agreementStatus,
                onChanged: (value) {
                  setState(() {
                    RegisterScreen.agreementStatus =
                        !RegisterScreen.agreementStatus;
                  });
                },
              ),
            ),
            horizontalGap(8),
            Flexible(
              child: RichText(
                text: TextSpan(
                  text: 'I agree to the ',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                      ),
                  children: [
                    TextSpan(
                        text: 'terms and conditions',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.cyanAccent,
                              fontWeight: FontWeight.bold,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                context, AgreementScreen.routePath);
                          }),
                    const TextSpan(text: ' as set out by the user agreement.'),
                  ],
                ),
                softWrap: true,
              ),
            )
          ],
        )
      ],
    );
  }
}
