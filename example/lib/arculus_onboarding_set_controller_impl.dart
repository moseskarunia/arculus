import 'package:example/arculus_onboarding_set_controller.dart';
import 'package:flutter/material.dart';

class ArculusOnboardingSetControllerImpl
    extends ArculusOnboardingSetController {
  @override
  Future<void> onAppleButtonPressed(BuildContext context) async {
    print('apple pressed!');
  }

  @override
  Future<void> onEmailButtonPressed(BuildContext context) async {
    print('email pressed!');
  }

  @override
  Future<void> onGoogleButtonPressed(BuildContext context) async {
    print('google pressed!');
  }
}
