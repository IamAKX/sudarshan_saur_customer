import 'dart:async';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

import '../../models/list_models/customer_list_model.dart';
import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_field_dark.dart';
import '../../widgets/primary_button.dart';

class ChangePhoneNumber extends StatefulWidget {
  const ChangePhoneNumber({super.key});
  static const String routePath = '/changePhoneNumber';

  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _newPhoneCtrl = TextEditingController();
  final TextEditingController _serialNumberCtrl = TextEditingController();
  final TextEditingController _otpCodeCtrl = TextEditingController();

  CustomerListModel? customerListModel;
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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
              'Change Mobile\nNumber',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Expanded(
              child: ListView(
                children: [
                  InputFieldDark(
                    hint: 'Old Mobile Number',
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    obscure: false,
                    icon: LineAwesomeIcons.phone,
                  ),
                  verticalGap(defaultPadding * 1.5),
                  InputFieldDark(
                    hint: 'New Mobile Number',
                    controller: _newPhoneCtrl,
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
                              startTimer();
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
                    hint: 'System Serial Number',
                    controller: _serialNumberCtrl,
                    keyboardType: TextInputType.text,
                    obscure: false,
                    icon: LineAwesomeIcons.plug,
                  ),
                  verticalGap(defaultPadding * 2),
                  PrimaryButton(
                    onPressed: () {},
                    label: 'Change Mobile Number',
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
