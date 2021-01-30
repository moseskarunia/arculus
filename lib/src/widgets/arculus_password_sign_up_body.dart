import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Predefined passowrd sign up body which can be easily implemented.
/// Will automatically manages interaction such as disabling text fields when
/// loading is processed, and disabling sign up button once tapped to prevent
/// multiple triggers.
class ArculusPasswordSignUpBody extends StatefulWidget {
  /// Controller which contains the functions to be used in sign up body.
  final ArculusPasswordSignUpController controller;

  /// Contains static UI-related data such as label, hints, etc.
  final ArculusSignUpStaticUIData uiData;

  /// Provide sign up state to modify the UI, such as errorMessage and isLoading
  final ArculusSignUpState signUpState;

  /// Will be applied to list view. If null, will use
  /// `EdgeInsets.symmetric(vertical: 16)`
  final EdgeInsets padding;

  const ArculusPasswordSignUpBody({
    Key key,
    @required this.controller,
    @required this.uiData,
    this.signUpState = const ArculusSignUpState(),
    this.padding,
  }) : super(key: key);

  @override
  _ArculusPasswordSignUpBodyState createState() =>
      _ArculusPasswordSignUpBodyState();
}

class _ArculusPasswordSignUpBodyState extends State<ArculusPasswordSignUpBody> {
  TextEditingController _usernameController,
      _passwordController,
      _retypedPasswordController;

  @override
  void initState() {
    super.initState();
    _usernameController =
        TextEditingController(text: widget.signUpState?.username ?? '');
    _passwordController =
        TextEditingController(text: widget.signUpState?.password ?? '');
    _retypedPasswordController =
        TextEditingController(text: widget.signUpState?.retypedPassword ?? '');
  }

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    _retypedPasswordController?.dispose();
    super.dispose();
  }

  Future<void> _signUp(BuildContext context) async {
    /// Close the keyboard
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    await widget.controller.onSignUpPressed(
      context,
      _usernameController.text,
      _passwordController.text,
      _retypedPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listViewChildren = [
      Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: TextField(
          key: Key('sign-up-username-field'),
          controller: _usernameController,
          decoration: InputDecoration(hintText: widget.uiData.usernameHint),
          enabled: !widget.signUpState.isLoading,
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: TextField(
          key: Key('sign-up-password-field'),
          controller: _passwordController,
          decoration: InputDecoration(hintText: widget.uiData.passwordHint),
          obscureText: true,
          enabled: !widget.signUpState.isLoading,
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 32),
        child: TextField(
          key: Key('sign-up-retyped-password-field'),
          controller: _retypedPasswordController,
          decoration: InputDecoration(
            hintText: widget.uiData.retypedPasswordHint,
          ),
          obscureText: true,
          enabled: !widget.signUpState.isLoading,
        ),
      ),
    ];

    Widget buttonChild = Text(widget.uiData.signUpButtonLabel);

    if (widget.signUpState.isLoading) {
      buttonChild = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buttonChild,
          Container(
            margin: const EdgeInsets.only(left: 16),
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              key: Key('sign-up-button-progress-indicator'),
              strokeWidth: 2,
            ),
          )
        ],
      );
    }

    listViewChildren.add(Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ElevatedButton(
        key: Key('sign-up-button'),
        onPressed: widget.signUpState.isLoading ? null : () => _signUp(context),
        child: buttonChild,
      ),
    ));

    if (widget.signUpState.errorMessage != null &&
        widget.signUpState.errorMessage.isNotEmpty) {
      listViewChildren.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          key: Key('sign-up-error-message'),
          children: [
            Icon(
              Icons.error,
              size: 14,
              color: Theme.of(context).errorColor,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.signUpState.errorMessage,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      key: Key('sign-up-root-list-view'),
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 16),
      children: listViewChildren,
    );
  }
}

abstract class ArculusPasswordSignUpController {
  /// Called when user tapping sign up pressed.
  Future<void> onSignUpPressed(
    BuildContext context,
    String username,
    String password,
    String retypedPassword,
  );
}

/// State of the sign up body.
class ArculusSignUpState extends Equatable {
  /// Error message from the result of sign up attempt. Will be automatically
  /// displayed at the bottom of sign up button if provided.
  final String errorMessage;

  /// If true, the button and text fields won't be interactable.
  final bool isLoading;

  /// Value of username, password, and retypedPassword. You can use this
  /// to show the user if there's any cached initial value.
  final String username, password, retypedPassword;

  const ArculusSignUpState({
    this.errorMessage,
    this.isLoading = false,
    this.username,
    this.password,
    this.retypedPassword,
  });

  @override
  List<Object> get props =>
      [errorMessage, isLoading, password, retypedPassword, username];
}

/// Static UI data of arculus sign up body.
class ArculusSignUpStaticUIData {
  /// Hint of the username field. e.g. "email", "username", "phoneNumber", etc.
  final String usernameHint;

  /// Hint of the password field.
  final String passwordHint;

  /// Hint of the retyped password field.
  final String retypedPasswordHint;

  /// Label of the sign up button. Will trigger [onSignUpPressed] when tapped.
  final String signUpButtonLabel;

  const ArculusSignUpStaticUIData({
    @required this.usernameHint,
    @required this.passwordHint,
    @required this.retypedPasswordHint,
    @required this.signUpButtonLabel,
  });
}
