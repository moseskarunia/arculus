import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Predefined passowrd sign in body which can be easily implemented.
/// Will automatically manages interaction such as disabling text fields when
/// loading is processed, and disabling sign in button once tapped to prevent
/// multiple triggers.
class ArculusPasswordSignInBody extends StatefulWidget {
  /// Controller which contains the functions to be used in sign in body.
  final ArculusSignInController controller;

  /// Contains static UI-related data such as label, hints, etc.
  final ArculusSignInStaticUIData uiData;

  /// Provide sign in state to modify the UI, such as errorMessage and isLoading
  final ArculusSignInState signInState;

  /// Will be applied to list view. If null, will use
  /// EdgeInsets.symmetric(vertical: 16)
  final EdgeInsets padding;

  const ArculusPasswordSignInBody({
    Key key,
    @required this.controller,
    @required this.uiData,
    this.padding,
    this.signInState,
  }) : super(key: key);

  @override
  _ArculusPasswordSignInBodyState createState() =>
      _ArculusPasswordSignInBodyState();
}

class _ArculusPasswordSignInBodyState extends State<ArculusPasswordSignInBody> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController =
        TextEditingController(text: widget.signInState.username ?? '');
    _passwordController =
        TextEditingController(text: widget.signInState.password ?? '');
  }

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  Future<void> _signIn(BuildContext context) async {
    /// Close the keyboard
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    await widget.controller.onSignInPressed(
      context,
      _usernameController.text,
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonChild = Text(widget.uiData.signInButtonLabel);

    if (widget.signInState.isLoading) {
      buttonChild = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buttonChild,
          Container(
            margin: const EdgeInsets.only(left: 16),
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              key: Key('sign-in-button-progress-indicator'),
              strokeWidth: 2,
            ),
          )
        ],
      );
    }

    final listViewChildren = <Widget>[
      Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: TextField(
          key: Key('sign-in-username'),
          controller: _usernameController,
          enabled: !widget.signInState.isLoading,
          decoration: InputDecoration(hintText: widget.uiData.usernameHint),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 32),
        child: TextField(
          key: Key('sign-in-password'),
          controller: _passwordController,
          enabled: !widget.signInState.isLoading,
          decoration: InputDecoration(hintText: widget.uiData.passwordHint),
          obscureText: true,
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: ElevatedButton(
          key: Key('sign-in-button'),
          child: buttonChild,
          onPressed:
              widget.signInState.isLoading ? null : () => _signIn(context),
        ),
      ),
    ];

    if (widget.signInState.errorMessage != null &&
        widget.signInState.errorMessage.isNotEmpty) {
      listViewChildren.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          key: Key('sign-in-error-message'),
          children: [
            Icon(
              Icons.error,
              size: 14,
              color: Theme.of(context).errorColor,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.signInState.errorMessage,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      );
    }

    if (widget.uiData.signUpActionLabel != null &&
        widget.uiData.signUpActionLabel.isNotEmpty) {
      final Widget action = InkWell(
        key: Key('sign-up-action'),
        onTap: () => widget.controller.onSignUpPressed(context),
        child: Text(
          widget.uiData.signUpActionLabel,
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(fontWeight: FontWeight.bold),
        ),
      );
      if (widget.uiData.signUpQuestionLabel != null &&
          widget.uiData.signUpQuestionLabel.isNotEmpty) {
        listViewChildren.add(Padding(
          key: Key('sign-up-padding'),
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            key: Key('sign-up-text-row'),
            children: [
              Text(
                widget.uiData.signUpQuestionLabel + ' ',
                key: Key('sign-up-question'),
                style: Theme.of(context).textTheme.caption,
              ),
              action
            ],
          ),
        ));
      } else {
        listViewChildren.add(
          Padding(
            key: Key('sign-up-padding'),
            padding: EdgeInsets.symmetric(vertical: 8),
            child: action,
          ),
        );
      }
    }

    if (widget.uiData.resetPasswordActionLabel != null &&
        widget.uiData.resetPasswordActionLabel.isNotEmpty) {
      final Widget action = InkWell(
        key: Key('reset-password-action'),
        onTap: () => widget.controller.onResetPasswordPressed(context),
        child: Text(
          widget.uiData.resetPasswordActionLabel,
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(fontWeight: FontWeight.bold),
        ),
      );
      if (widget.uiData.resetPasswordQuestionLabel != null &&
          widget.uiData.resetPasswordQuestionLabel.isNotEmpty) {
        listViewChildren.add(Padding(
          key: Key('reset-password-padding'),
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            key: Key('reset-password-text-row'),
            children: [
              Text(
                widget.uiData.resetPasswordQuestionLabel + ' ',
                key: Key('reset-password-question'),
                style: Theme.of(context).textTheme.caption,
              ),
              action
            ],
          ),
        ));
      } else {
        listViewChildren.add(
          Padding(
            key: Key('reset-password-padding'),
            padding: EdgeInsets.symmetric(vertical: 8),
            child: action,
          ),
        );
      }
    }

    return ListView(
      key: Key('sign-in-root-list-view'),
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 16),
      children: listViewChildren,
    );
  }
}

/// State of the sign in attempt. It can contains errorMessage, and Session.
/// [errorMessage] determines if the state is `isAuthenticated` or not.
///
/// The arculus sign in body will automatically displays the error message
/// at the bottom of sign in button if provided, and prevents it from calling
/// [onAuthenticated].
class ArculusSignInState extends Equatable {
  /// Error message from the result of sign in attempt.
  final String errorMessage;

  /// If true, the button and text field won't be interactable.
  final bool isLoading;

  /// Value of username and password. You can use this to show the user if
  /// there's any cached initial value.
  final String username, password;

  const ArculusSignInState({
    this.errorMessage,
    this.isLoading = false,
    this.username,
    this.password,
  });

  @override
  List<Object> get props => [errorMessage, isLoading, username, password];
}

/// Controller which contains callbacks pf arculus sign in body.
abstract class ArculusSignInController {
  /// Triggered when sign in button is tapped.
  Future<void> onSignInPressed(
    BuildContext context,
    String username,
    String password,
  );

  /// Triggered when the [resetPasswordActionLabel] is pressed.
  Future<void> onResetPasswordPressed(BuildContext context);

  /// Triggered when the [signUpActionLabel] is pressed.
  Future<void> onSignUpPressed(BuildContext context);
}

/// Static UI data of arculus sign in body.
class ArculusSignInStaticUIData {
  /// Hint of the username field. e.g. "email", "username", "phoneNumber", etc.
  final String usernameHint;

  /// Hint of the password field.
  final String passwordHint;

  /// Label of the sign in button. Will trigger [onSignInPressed] when tapped.
  final String signInButtonLabel;

  /// Question on the reset password label. This label is not interactable,
  /// just to make the message more friendly. The interactable label is
  /// [resetPasswordActionLabel].
  final String resetPasswordQuestionLabel;

  /// Action label which will be placed after [resetPasswordQuestionLabel].
  /// Will trigger [onResetPasswordPressed].
  ///
  /// If null or empty, reset password option is not displayed
  final String resetPasswordActionLabel;

  /// Question on the sign up label. This label is not interactable,
  /// just to make the message more friendly. The interactable label is
  /// [signUpActionLabel].
  final String signUpQuestionLabel;

  /// Action label which will be placed after [signUpQuestionLabel].
  /// Will trigger [onRegisterPressed] when pressed.
  ///
  /// If null or empty, sign up option is not displayed
  final String signUpActionLabel;

  const ArculusSignInStaticUIData({
    @required this.usernameHint,
    @required this.passwordHint,
    @required this.signInButtonLabel,
    this.resetPasswordActionLabel,
    this.signUpActionLabel,
    this.resetPasswordQuestionLabel,
    this.signUpQuestionLabel,
  });
}
