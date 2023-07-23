import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/theme.dart';
import '../../widgets/gaps.dart';

class BlockedUserScreen extends StatefulWidget {
  const BlockedUserScreen({super.key});
  static const String routePath = '/blockedUserScreen';

  @override
  State<BlockedUserScreen> createState() => _BlockedUserScreenState();
}

class _BlockedUserScreenState extends State<BlockedUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/svg/suspended.svg',
              width: 200,
            ),
            verticalGap(defaultPadding * 2),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
              child: Text(
                'You profile is inactive. Please contact admin or wait for 24 hours.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            verticalGap(defaultPadding * 2),
            ElevatedButton(
              onPressed: () async {
                String email = Uri.encodeComponent("info@sudarshansaur.com");
                Uri mail = Uri.parse("mailto:$email");
                await launchUrl(mail);
              },
              child: const Text('Contact Admin'),
            )
          ],
        ),
      ),
    );
  }
}
