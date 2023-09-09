import 'dart:async';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/main.dart';
import 'package:saur_customer/models/user_model.dart';
import 'package:saur_customer/models/warranty_model.dart';
import 'package:saur_customer/screens/raise_warranty_request/installation_address_screen.dart';
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

  late ApiProvider _api;

  String code = '';

  Timer? _timer;
  static const int otpResendThreshold = 10;
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
            verticalGap(defaultPadding * 1.5),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            verticalGap(defaultPadding),
            Text(
              'New\nAccount 🙋🏼‍♂️',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            verticalGap(defaultPadding * 1.5),
            Expanded(
              child: ListView(
                children: [
                  InputFieldDark(
                    hint: 'Full Name',
                    controller: _nameCtrl,
                    keyboardType: TextInputType.name,
                    obscure: false,
                    icon: LineAwesomeIcons.user,
                  ),
                  verticalGap(defaultPadding * 1.5),
                  InputFieldDark(
                    hint: 'Phone Number',
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
                                    'Enter valid 10 digit phone number');
                                return;
                              }
                              code = getOTPCode();
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
                  verticalGap(defaultPadding),
                  InputFieldDark(
                    hint: 'OTP',
                    controller: _otpCodeCtrl,
                    keyboardType: TextInputType.number,
                    obscure: false,
                    icon: LineAwesomeIcons.lock,
                  ),
                  verticalGap(defaultPadding * 1.5),
                  InputFieldDark(
                    hint: 'Serial Number',
                    controller: _serialNumberCtrl,
                    keyboardType: TextInputType.text,
                    obscure: false,
                    icon: LineAwesomeIcons.plug,
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

                      if (_otpCodeCtrl.text != code) {
                        SnackBarService.instance
                            .showSnackBarError('Incorrect OTP');
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
                          status: UserStatus.CREATED.name);
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
                ],
              ),
            ),
            verticalGap(defaultPadding),
          ],
        ),
      ),
    );
  }
}
