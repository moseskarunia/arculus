import 'package:example/arculus_onboarding_set_controller.dart';
import 'package:flutter/material.dart';
import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';

/// Widget to easily applies arculus-style onboarding page. Designed to be put
/// under Scaffold's body.
class ArculusOnboardingSet extends StatelessWidget {
  final ArculusOnboardingSetController controller;
  final Widget branding;
  final EdgeInsetsGeometry padding;
  final String emailButtonLabel;
  final String googleButtonLabel;
  final String appleButtonLabel;
  final bool isEmailButtonVisible;
  final bool isGoogleButtonVisible;
  final bool isAppleButtonVisible;
  final double width;

  const ArculusOnboardingSet({
    Key key,
    @required this.controller,
    this.branding,
    this.padding,
    this.emailButtonLabel,
    this.googleButtonLabel,
    this.appleButtonLabel,
    this.isEmailButtonVisible = false,
    this.isGoogleButtonVisible = false,
    this.isAppleButtonVisible = false,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Expanded(
        child: branding ?? SizedBox(),
      ),
    ];

    if (emailButtonLabel != null &&
        emailButtonLabel.isNotEmpty &&
        isEmailButtonVisible) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 16),
        child: ArculusEmailButton(
          label: emailButtonLabel,
          onPressed: controller.onEmailButtonPressed,
        ),
      ));
    }

    if (appleButtonLabel != null &&
        appleButtonLabel.isNotEmpty &&
        isAppleButtonVisible) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 16),
        child: ArculusAppleButton(
          label: appleButtonLabel,
          onPressed: controller.onAppleButtonPressed,
        ),
      ));
    }
    if (googleButtonLabel != null &&
        googleButtonLabel.isNotEmpty &&
        isGoogleButtonVisible) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 16),
        child: ArculusGoogleButton(
          label: googleButtonLabel,
          onPressed: controller.onGoogleButtonPressed,
        ),
      ));
    }

    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
