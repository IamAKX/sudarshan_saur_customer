import 'dart:async';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/main.dart';
import 'package:saur_customer/models/user_model.dart';
import 'package:saur_customer/models/warranty_model.dart';
import 'package:saur_customer/screens/raise_warranty_request/installation_address_screen.dart';
import 'package:saur_customer/screens/user_onboarding/login_screen.dart';
import 'package:saur_customer/utils/enum.dart';
import 'package:saur_customer/utils/helper_method.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:saur_customer/widgets/gaps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/colors.dart';
import '../../utils/preference_key.dart';
import '../../widgets/input_field_dark.dart';
import '../../widgets/primary_button.dart';
import 'agreement_screen.dart';
import 'change_phone_number.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routePath = '/register';
  static bool agreementStatus = false;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _serialNumberCtrl = TextEditingController();
  final TextEditingController _otpCodeCtrl = TextEditingController();
  final TextEditingController _installerMobileCtrl = TextEditingController();

  late ApiProvider _api;

  String code = '';

  Timer? _timer;
  static const int otpResendThreshold = 30;
  int _secondsRemaining = otpResendThreshold;
  bool _timerActive = false;

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
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);

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
            verticalGap(defaultPadding),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            verticalGap(defaultPadding),
            Text(
              'New\nAccount',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Expanded(
              child: ListView(
                children: [
                  InputFieldDark(
                    hint: 'Customer Full Name',
                    controller: _nameCtrl,
                    keyboardType: TextInputType.name,
                    obscure: false,
                    icon: LineAwesomeIcons.user,
                  ),
                  verticalGap(defaultPadding * 1.5),
                  InputFieldDark(
                    hint: 'Customer Mobile Number',
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    obscure: false,
                    icon: LineAwesomeIcons.phone,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _timerActive
                          ? null
                          : () {
                              if (_phoneCtrl.text.length != 10 ||
                                  !isNumeric(_phoneCtrl.text)) {
                                SnackBarService.instance.showSnackBarError(
                                    'Enter valid 10 digit mobile number');
                                return;
                              }
                              code = getOTPCode();
                              log('OTP = $code');
                              startTimer();
                              _api.sendOtp(_phoneCtrl.text, code);
                            },
                      child: Text(
                        _timerActive
                            ? 'Resend in $_secondsRemaining seconds'
                            : 'Send OTP',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  // verticalGap(defaultPadding),
                  InputFieldDark(
                    hint: 'OTP',
                    controller: _otpCodeCtrl,
                    keyboardType: TextInputType.number,
                    obscure: false,
                    icon: LineAwesomeIcons.lock,
                  ),
                  verticalGap(defaultPadding * 1.5),
                  InputFieldDark(
                    hint: 'System Serial Number',
                    controller: _serialNumberCtrl,
                    keyboardType: TextInputType.number,
                    obscure: false,
                    icon: LineAwesomeIcons.plug,
                    maxChar: 6,
                  ),
                  InputFieldDark(
                    hint: 'Installer Mobile Number',
                    controller: _installerMobileCtrl,
                    keyboardType: TextInputType.phone,
                    obscure: false,
                    icon: LineAwesomeIcons.phone,
                  ),
                  verticalGap(defaultPadding / 2),
                  Row(
                    children: [
                      Theme(
                        data: ThemeData(
                          checkboxTheme: CheckboxThemeData(
                            side:
                                const BorderSide(color: Colors.white, width: 2),
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
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.white,
                                ),
                            children: [
                              TextSpan(
                                  text: 'terms and conditions',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Colors.cyanAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, AgreementScreen.routePath);
                                    }),
                              const TextSpan(
                                  text: ' as set out by the user agreement.'),
                            ],
                          ),
                          softWrap: true,
                        ),
                      )
                    ],
                  ),

                  verticalGap(defaultPadding * 2),
                  PrimaryButton(
                    onPressed: () async {
                      if (_nameCtrl.text.isEmpty ||
                          _phoneCtrl.text.isEmpty ||
                          _otpCodeCtrl.text.isEmpty ||
                          _serialNumberCtrl.text.isEmpty) {
                        SnackBarService.instance
                            .showSnackBarError('All fields are mandatory');
                        return;
                      }

                      if (!isValidPhoneNumber(_phoneCtrl.text)) {
                        SnackBarService.instance
                            .showSnackBarError('Invalid phone number');
                        return;
                      }

                      if (!isValidSerialNumber(_serialNumberCtrl.text)) {
                        SnackBarService.instance
                            .showSnackBarError('Invalid Serial number');
                        return;
                      }

                      if (_otpCodeCtrl.text != code) {
                        SnackBarService.instance
                            .showSnackBarError('Incorrect OTP');
                        return;
                      }
                      if (!RegisterScreen.agreementStatus) {
                        SnackBarService.instance.showSnackBarError(
                            'Read and accept terms and condition');
                        return;
                      }
                      WarrantyModel? warrantyModel = await _api
                          .getDeviceBySerialNo(_serialNumberCtrl.text);
                      if (warrantyModel == null) {
                        SnackBarService.instance
                            .showSnackBarError('Invalid serial number');
                        return;
                      }
                      UserModel userModel = UserModel(
                          customerName: _nameCtrl.text,
                          mobileNo: _phoneCtrl.text,
                          installerMobile: _installerMobileCtrl.text,
                          status: UserStatus.ACTIVE.name);
                      _api.createUser(userModel).then((value) async {
                        if (value) {
                          UserModel? newUser =
                              await _api.getUserByPhone(_phoneCtrl.text);
                          prefs.setString(SharedpreferenceKey.serialNumber,
                              _serialNumberCtrl.text);
                          prefs.setString(
                              SharedpreferenceKey.userPhone, _phoneCtrl.text);
                          prefs.setInt(SharedpreferenceKey.userId,
                              newUser?.customerId ?? -1);
                          Navigator.pushNamed(
                              context, InstallationAddressScreen.routePath);
                        }
                      });
                    },
                    label: 'Register',
                    isDisabled: _api.status == ApiStatus.loading,
                    isLoading: _api.status == ApiStatus.loading,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.routePath, (route) => false);
                        },
                        child: Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        color: Colors.white,
                        width: 2,
                        height: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ChangePhoneNumber.routePath);
                        },
                        child: Text(
                          'Change Mobile Number',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
