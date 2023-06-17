import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:saur_customer/screens/user_onboarding/agreement_text.dart';

import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../../widgets/gaps.dart';

class AgreementScreen extends StatelessWidget {
  const AgreementScreen({super.key});
  static const String routePath = '/agreement';

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
            Text(
              'Terms and\nConditions 📝',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            verticalGap(defaultPadding),
            Expanded(
              child: ListView(
                children: [
                  Html(
                    data: agreementText,
                    style: {
                      'body':
                          Style(color: Colors.white, fontSize: FontSize.large),
                      'h4': Style(
                          color: Colors.white,
                          fontSize: FontSize.xLarge,
                          fontWeight: FontWeight.bold),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
