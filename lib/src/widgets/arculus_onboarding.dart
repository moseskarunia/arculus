import 'package:flutter/material.dart';
import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';

/// Widget to easily apply arculus-style onboarding page. Designed to be put
/// under Scaffold's body.
class ArculusOnboarding extends StatelessWidget {
  /// Branding, logo, or similar to put on top of [buttons]
  final Widget branding;

  /// Outer padding of all widget set
  final EdgeInsetsGeometry padding;

  /// Max width of the container. If null, will use
  /// `MediaQuery.of(context).size.width`.
  final double width;

  /// Will be placed at the bottom-most of the page. e.g. You can use
  /// [ArculusGoogleButton] for this.
  final List<Widget> buttons;

  const ArculusOnboarding({
    Key key,
    this.branding,
    this.padding,
    this.width,
    this.buttons = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [Expanded(child: branding ?? SizedBox())];

    children = [...buttons];

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
