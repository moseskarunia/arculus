import 'package:example/arculus_onboarding_set_controller.dart';
import 'package:flutter/material.dart';
import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';

/// Widget to easily apply arculus-style onboarding page. Designed to be put
/// under Scaffold's body.
class ArculusOnboardingSet extends StatelessWidget {
  /// Controller which responsible as onPressed callback.
  final ArculusOnboardingSetController controller;

  /// Branding, logo, or similar to put on top of the buttons
  final Widget branding;

  /// Outer padding of all widget set
  final EdgeInsetsGeometry padding;

  /// Will be visible only if neither null or empty string
  /// and [isEmailButtonVisible] true
  final String emailButtonLabel;

  /// Will be visible only if neither null or empty string
  /// and [isGoogleButtonVisible] true
  final String googleButtonLabel;

  /// Will be visible only if neither null or empty string
  /// and [isAppleButtonVisible] true
  final String appleButtonLabel;

  /// Will be visible only if true, and [emailButtonLabel]
  /// is neither null or empty string
  final bool isEmailButtonVisible;

  /// Will be visible only if true, and [googleButtonLabel]
  /// is neither null or empty string
  final bool isGoogleButtonVisible;

  /// Will be visible only if true, and [appleButtonLabel]
  /// is neither null or empty string
  final bool isAppleButtonVisible;

  /// Max width of the container. If null, will use
  /// `MediaQuery.of(context).size.width`.
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
