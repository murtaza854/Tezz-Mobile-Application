import 'package:app/components/default_button.dart';
import 'package:app/screens/onboardingSignup/onboarding_signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class MobileProfileScreen extends StatefulWidget {
  const MobileProfileScreen({Key? key}) : super(key: key);

  @override
  State<MobileProfileScreen> createState() => _MobileProfileScreenState();
}

class _MobileProfileScreenState extends State<MobileProfileScreen> {
  String buttonText = 'Sign Out';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        width: 300,
        height: 300,
        child: Center(
          child: DefaultButton(
            text: buttonText,
            press: () async {
              if (buttonText == 'Sign Out') {
                setState(() {
                  buttonText = 'Signing Out...';
                });
                await FirebaseAuth.instance.signOut();
                OneSignal.shared.removeExternalUserId();
                Future.delayed(const Duration(seconds: 3)).then((_) {
                  Navigator.pushNamed(
                      context, OnboardingSignupScreen.routeName);
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
