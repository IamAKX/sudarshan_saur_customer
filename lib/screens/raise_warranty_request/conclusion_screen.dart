import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/main.dart';
import 'package:saur_customer/models/user_model.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/home_container/home_container.dart';
import 'package:saur_customer/screens/user_onboarding/login_screen.dart';
import 'package:saur_customer/utils/colors.dart';
import 'package:saur_customer/utils/constants.dart';
import 'package:saur_customer/utils/preference_key.dart';
import 'package:saur_customer/widgets/gaps.dart';

import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/theme.dart';

class ConclusionScreen extends StatefulWidget {
  const ConclusionScreen({
    super.key,
  });
  static const String routePath = '/conclusionScreen';

  @override
  State<ConclusionScreen> createState() => _ConclusionScreenState();
}

class _ConclusionScreenState extends State<ConclusionScreen> {
  late ApiProvider _api;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {}

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Request Submitted',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: getBody(context));
  }

  getBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(defaultPadding),
      children: [
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(Constants.conclusionMessage),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(defaultPadding / 2),
              border: Border.all(color: hintColor)),
        ),
        verticalGap(defaultPadding),
        ElevatedButton(
          onPressed: () {
            if (prefs.containsKey(SharedpreferenceKey.loggedIn)) {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeContainer.routePath, (route) => false);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.routePath, (route) => false);
            }
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
