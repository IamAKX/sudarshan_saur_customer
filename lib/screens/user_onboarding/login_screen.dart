import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/raise_warranty_request/other_information_screen.dart';
import 'package:saur_customer/screens/user_onboarding/change_phone_number.dart';
import 'package:saur_customer/screens/user_onboarding/register_screen.dart';
import 'package:saur_customer/utils/colors.dart';
import 'package:saur_customer/utils/helper_method.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:saur_customer/widgets/gaps.dart';
import 'package:saur_customer/widgets/input_field_dark.dart';
import 'package:saur_customer/widgets/primary_button.dart';
import 'package:string_validator/string_validator.dart';

import '../../main.dart';
import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/enum.dart';
import '../../utils/preference_key.dart';
import '../blocked_user/blocked_users_screen.dart';
import '../home_container/home_container.dart';
import '../raise_warranty_request/conclusion_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routePath = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();
  String code = '';
  late ApiProvider _api;

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
  void dispose() {
    if (_timer != null) _timer?.cancel();
    super.dispose();
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
      child: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
                vertical: defaultPadding,
              ),
              children: [
                verticalGap(defaultPadding * 1.5),
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                verticalGap(defaultPadding),
                Text(
                  'Welcome\nBack',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
                                  'Enter valid 10 digit mobil number');
                              return;
                            }
                            startTimer();
                            code = getOTPCode();
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
                InputFieldDark(
                  hint: 'OTP',
                  controller: _otpCtrl,
                  keyboardType: TextInputType.number,
                  obscure: false,
                  icon: LineAwesomeIcons.lock,
                ),
                verticalGap(defaultPadding * 2),
                PrimaryButton(
                  onPressed: () {
                    if (_otpCtrl.text == code ||
                        isTestUser(_phoneCtrl.text, _otpCtrl.text)) {
                      _api.getUserByPhone(_phoneCtrl.text).then((value) {
                        if (value == null) {
                          SnackBarService.instance
                              .showSnackBarError('User not registered');
                          return;
                        }

                        prefs.setString(SharedpreferenceKey.userPhone,
                            value.mobileNo ?? '');
                        prefs.setInt(
                            SharedpreferenceKey.userId, value.customerId ?? -1);

                        if (value.status == UserStatus.ACTIVE.name) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomeContainer.routePath,
                            (route) => false,
                          );
                        } else if (value.status == UserStatus.PENDING.name ||
                            value.status == UserStatus.CREATED.name) {
                          Navigator.pushNamedAndRemoveUntil(context,
                              ConclusionScreen.routePath, (route) => false,
                              arguments: value.customerName ?? 'User');
                        } else if (value.status == UserStatus.SUSPENDED.name) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            BlockedUserScreen.routePath,
                            (route) => false,
                          );
                        }
                      });
                    } else {
                      SnackBarService.instance
                          .showSnackBarError('Incorrect OTP');
                    }
                  },
                  label: 'Login',
                  isDisabled: _api.status == ApiStatus.loading,
                  isLoading: _api.status == ApiStatus.loading,
                ),
                verticalGap(defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await prefs.clear();
                        Navigator.pushNamed(context, RegisterScreen.routePath);
                      },
                      child: Text(
                        'Register',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
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
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Image.asset(
                'assets/logo/logo.png',
                width: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isTestUser(String phone, String otp) {
    if (phone == '9804945122' && otp == '123456') {
      return true;
    }
    return false;
  }
}
