import 'package:flutter/material.dart';

abstract class ArculusOnboardingSetController {
  Future<void> onGoogleButtonPressed(BuildContext context);
  Future<void> onEmailButtonPressed(BuildContext context);
  Future<void> onAppleButtonPressed(BuildContext context);
}
