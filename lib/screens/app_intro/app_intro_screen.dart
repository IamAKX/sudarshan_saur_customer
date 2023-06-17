import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../user_onboarding/login_screen.dart';
import 'app_intro_message.dart';

class AppIntroScreen extends StatefulWidget {
  const AppIntroScreen({super.key});
  static const String routePath = '/';
  @override
  State<AppIntroScreen> createState() => _AppIntroScreenState();
}

class _AppIntroScreenState extends State<AppIntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).pushNamed(LoginScreen.routePath);
  }

  Widget _buildImage(String assetName) {
    return Stack(
      children: [
        Image.asset(
          'assets/banners/$assetName',
          fit: BoxFit.cover,
          height: 400,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: defaultPadding * 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.8),
                  Colors.white,
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: textColorDark,
          ),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildBody(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge!,
      textAlign: TextAlign.left,
    );
  }

  Widget getBody(BuildContext context) {
    PageDecoration pageDecoration = const PageDecoration(
      pageColor: Colors.white,
    );
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: background,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      pages: [
        PageViewModel(
          titleWidget: _buildTitle(AppIntroMessage.title1),
          bodyWidget: _buildBody(AppIntroMessage.message1),
          image: _buildImage('banner-slider1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: _buildTitle(AppIntroMessage.title2),
          bodyWidget: _buildBody(AppIntroMessage.message2),
          image: _buildImage('banner-slider2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: _buildTitle(AppIntroMessage.title3),
          bodyWidget: _buildBody(AppIntroMessage.message3),
          image: _buildImage('banner-slider4.png'),
          decoration: pageDecoration,
        ),
      ],
      initialPage: 0,
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      // rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: Text('Skip', style: Theme.of(context).textTheme.labelLarge),
      next: const Icon(Icons.arrow_forward),
      done: Text('Start', style: Theme.of(context).textTheme.labelLarge),
      curve: Curves.fastLinearToSlowEaseIn,
      // controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
