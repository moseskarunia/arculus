import 'package:arculus/src/widgets/arculus_password_sign_in_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockController extends Mock implements ArculusSignInController {}

void main() {
  MockController controller;

  setUp(() {
    controller = MockController();
  });

  group('ArculusSignInState', () {
    test('props', () {
      final state = ArculusSignInState(
        username: 'test@test.com',
        password: 'admin12345',
        errorMessage: 'Invalid username',
        isLoading: true,
      );
      expect(state.props, [
        'Invalid username',
        true,
        'test@test.com',
        'admin12345',
      ]);
    });
  });

  group('root ListView', () {
    final uiDataFixture = ArculusSignInStaticUIData(
      usernameHint: 'Email or username',
      passwordHint: 'Password',
      signInButtonLabel: 'SIGN IN',
    );
    testWidgets('should use provided padding', (tester) async {
      final stateFixture = ArculusSignInState();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ArculusPasswordSignInBody(
            controller: controller,
            uiData: uiDataFixture,
            signInState: stateFixture,
            padding: EdgeInsets.all(16),
          ),
        ),
      ));

      final listViewFinder = find.byKey(Key('sign-in-root-list-view'));
      final listView = tester.widget<ListView>(listViewFinder);
      expect(listView.padding, EdgeInsets.all(16));
    });
    testWidgets('should use default padding', (tester) async {
      final stateFixture = ArculusSignInState();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ArculusPasswordSignInBody(
            controller: controller,
            uiData: uiDataFixture,
            signInState: stateFixture,
          ),
        ),
      ));

      final listViewFinder = find.byKey(Key('sign-in-root-list-view'));
      final listView = tester.widget<ListView>(listViewFinder);
      expect(listView.padding, EdgeInsets.symmetric(vertical: 16));
    });
  });

  group('username TextField', () {
    final uiDataFixture = ArculusSignInStaticUIData(
      usernameHint: 'Email or username',
      passwordHint: 'Password',
      signInButtonLabel: 'SIGN IN',
    );

    testWidgets(
      'should be wrapped in container with 16 bottom margin',
      (tester) async {
        final stateFixture = ArculusSignInState();

        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ArculusPasswordSignInBody(
              controller: controller,
              uiData: uiDataFixture,
              signInState: stateFixture,
            ),
          ),
        ));

        final usernameFieldFinder = find.byKey(Key('sign-in-username'));
        final containerWrapperFinder = find
            .ancestor(of: usernameFieldFinder, matching: find.byType(Container))
            .first;

        expect(
          tester.widget<Container>(containerWrapperFinder).margin,
          EdgeInsets.only(bottom: 16),
        );
      },
    );
    testWidgets(
      'should be empty with provided hint when no username provided in state',
      (tester) async {
        final stateFixture = ArculusSignInState();

        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ArculusPasswordSignInBody(
              controller: controller,
              uiData: uiDataFixture,
              signInState: stateFixture,
            ),
          ),
        ));

        final usernameFieldFinder = find.byKey(Key('sign-in-username'));
        final usernameTextField = tester.widget<TextField>(usernameFieldFinder);

        expect(
          usernameTextField.decoration.hintText,
          uiDataFixture.usernameHint,
        );
        expect(usernameTextField.controller.text, '');
      },
    );

    testWidgets(
      'should assign state.username if provided',
      (tester) async {
        final stateFixture = ArculusSignInState(username: 'test@test.com');

        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ArculusPasswordSignInBody(
              controller: controller,
              uiData: uiDataFixture,
              signInState: stateFixture,
            ),
          ),
        ));

        final usernameFieldFinder = find.byKey(Key('sign-in-username'));
        final usernameTextField = tester.widget<TextField>(usernameFieldFinder);

        expect(
          usernameTextField.decoration.hintText,
          uiDataFixture.usernameHint,
        );
        expect(usernameTextField.controller.text, 'test@test.com');
      },
    );

    testWidgets('should not be editable when state.isLoading', (tester) async {
      final stateFixture = ArculusSignInState(
        username: 'test@test.com',
        password: 'admin123',
        isLoading: true,
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ArculusPasswordSignInBody(
            controller: controller,
            uiData: uiDataFixture,
            signInState: stateFixture,
          ),
        ),
      ));

      final usernameFieldFinder = find.byKey(Key('sign-in-username'));
      final usernameTextField = tester.widget<TextField>(usernameFieldFinder);

      expect(
        usernameTextField.decoration.hintText,
        uiDataFixture.usernameHint,
      );
      expect(usernameTextField.controller.text, 'test@test.com');
      expect(usernameTextField.enabled, false);
    });
  });

  group('password TextField', () {
    final uiDataFixture = ArculusSignInStaticUIData(
      usernameHint: 'Email or username',
      passwordHint: 'Password',
      signInButtonLabel: 'SIGN IN',
    );

    testWidgets(
      'should be wrapped in container with 32 bottom margin with ',
      (tester) async {
        final stateFixture = ArculusSignInState();

        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ArculusPasswordSignInBody(
              controller: controller,
              uiData: uiDataFixture,
              signInState: stateFixture,
            ),
          ),
        ));

        final passwordFieldFinder = find.byKey(Key('sign-in-password'));
        final containerWrapperFinder = find
            .ancestor(of: passwordFieldFinder, matching: find.byType(Container))
            .first;

        expect(
          tester.widget<Container>(containerWrapperFinder).margin,
          EdgeInsets.only(bottom: 32),
        );
      },
    );
    testWidgets(
      'should be empty with provided hint when no password provided in state',
      (tester) async {
        final stateFixture = ArculusSignInState();

        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ArculusPasswordSignInBody(
              controller: controller,
              uiData: uiDataFixture,
              signInState: stateFixture,
            ),
          ),
        ));

        final passwordFieldFinder = find.byKey(Key('sign-in-password'));
        final passwordTextField = tester.widget<TextField>(passwordFieldFinder);

        expect(
          passwordTextField.decoration.hintText,
          uiDataFixture.passwordHint,
        );
        expect(passwordTextField.controller.text, '');
        expect(passwordTextField.obscureText, true);
      },
    );

    testWidgets(
      'should assign state.password if provided',
      (tester) async {
        final stateFixture = ArculusSignInState(password: 'admin123');

        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ArculusPasswordSignInBody(
              controller: controller,
              uiData: uiDataFixture,
              signInState: stateFixture,
            ),
          ),
        ));

        final passwordFieldFinder = find.byKey(Key('sign-in-password'));
        final passwordTextField = tester.widget<TextField>(passwordFieldFinder);

        expect(
          passwordTextField.decoration.hintText,
          uiDataFixture.passwordHint,
        );
        expect(passwordTextField.controller.text, 'admin123');
      },
    );

    testWidgets('should not be editable when state.isLoading', (tester) async {
      final stateFixture = ArculusSignInState(
        username: 'test@test.com',
        password: 'admin123',
        isLoading: true,
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ArculusPasswordSignInBody(
            controller: controller,
            uiData: uiDataFixture,
            signInState: stateFixture,
          ),
        ),
      ));

      final passwordFieldFinder = find.byKey(Key('sign-in-password'));
      final passwordTextField = tester.widget<TextField>(passwordFieldFinder);

      expect(
        passwordTextField.decoration.hintText,
        uiDataFixture.passwordHint,
      );
      expect(passwordTextField.controller.text, 'admin123');
      expect(passwordTextField.enabled, false);
    });
  });

  group('sign in button', () {
    final uiDataFixture = ArculusSignInStaticUIData(
      usernameHint: 'Email or username',
      passwordHint: 'Password',
      signInButtonLabel: 'SIGN IN',
    );

    testWidgets(
      'should be labelled with uiData.signInButtonLabel',
      (tester) async {
        final stateFixture = ArculusSignInState(
          username: 'test@test.com',
          password: 'admin123',
        );

        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ArculusPasswordSignInBody(
              controller: controller,
              uiData: uiDataFixture,
              signInState: stateFixture,
            ),
          ),
        ));

        final buttonFinder = find.byKey(Key('sign-in-button'));
        final button = tester.widget<ElevatedButton>(buttonFinder);

        final buttonTextFinder = find
            .descendant(of: buttonFinder, matching: find.byType(Text))
            .first;
        final text = tester.widget<Text>(buttonTextFinder);

        expect(text.data, uiDataFixture.signInButtonLabel);
        expect(button.enabled, true);

        await tester.tap(buttonFinder);
        verify(controller.onSignInPressed(any, 'test@test.com', 'admin123'))
            .called(1);
      },
    );
    testWidgets(
      'should be disabled when state.isLoading',
      (tester) async {
        final stateFixture = ArculusSignInState(
          username: 'test@test.com',
          password: 'admin123',
          isLoading: true,
        );

        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ArculusPasswordSignInBody(
              controller: controller,
              uiData: uiDataFixture,
              signInState: stateFixture,
            ),
          ),
        ));

        final buttonFinder = find.byKey(Key('sign-in-button'));
        final button = tester.widget<ElevatedButton>(buttonFinder);

        final buttonTextFinder = find
            .descendant(of: buttonFinder, matching: find.byType(Text))
            .first;
        final text = tester.widget<Text>(buttonTextFinder);

        expect(text.data, uiDataFixture.signInButtonLabel);
        expect(button.enabled, false);

        final progressIndicatorFinder = find.byKey(
          Key('sign-in-button-progress-indicator'),
        );
        final progressIndicator =
            tester.widget<CircularProgressIndicator>(progressIndicatorFinder);

        expect(progressIndicatorFinder, findsOneWidget);
        expect(progressIndicator.strokeWidth, 2);

        final progressWrapperFinder = find
            .ancestor(
              of: progressIndicatorFinder,
              matching: find.byType(Container),
            )
            .first;

        final progressWrapper = tester.widget<Container>(progressWrapperFinder);

        expect(
          progressWrapper.constraints,
          BoxConstraints.tightFor(width: 12, height: 12),
        );
        expect(progressWrapper.margin, EdgeInsets.only(left: 16));

        tester.tap(buttonFinder);
        verifyNever(
            controller.onSignInPressed(any, 'test@test.com', 'admin123'));
      },
    );
  });

  group('error message', () {
    final uiDataFixture = ArculusSignInStaticUIData(
      usernameHint: 'Email or username',
      passwordHint: 'Password',
      signInButtonLabel: 'SIGN IN',
    );

    testWidgets('should NOT be visible when state.errorMessage is null',
        (tester) async {
      final stateFixture = ArculusSignInState(
        username: 'test@test.com',
        password: 'admin123',
      );

      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(errorColor: Colors.orange),
        home: Scaffold(
          body: ArculusPasswordSignInBody(
            controller: controller,
            uiData: uiDataFixture,
            signInState: stateFixture,
          ),
        ),
      ));
      expect(find.byKey(Key('sign-in-error-message')), findsNothing);
    });

    testWidgets(
      'should be visible when state.errorMessage is provided',
      (tester) async {
        final stateFixture = ArculusSignInState(
          username: 'test@test.com',
          password: 'admin123',
          errorMessage:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        );

        await tester.pumpWidget(MaterialApp(
          theme: ThemeData.from(
            colorScheme: ColorScheme.light(),
            textTheme: Typography.englishLike2018,
          ).copyWith(errorColor: Colors.orange),
          home: Scaffold(
            body: ArculusPasswordSignInBody(
              controller: controller,
              uiData: uiDataFixture,
              signInState: stateFixture,
            ),
          ),
        ));

        final errorMessageFinder = find.byKey(Key('sign-in-error-message'));
        final message = tester.widget<Row>(errorMessageFinder);

        expect(message.crossAxisAlignment, CrossAxisAlignment.center);

        final iconFinder = find.descendant(
            of: errorMessageFinder, matching: find.byType(Icon));
        final icon = tester.widget<Icon>(iconFinder);
        expect(icon.icon, Icons.error);
        expect(icon.size, 14);
        expect(icon.color, Colors.orange);

        final textFinder = find.descendant(
          of: errorMessageFinder,
          matching: find.byType(Text),
        );
        final text = tester.widget<Text>(textFinder);
        expect(text.data, stateFixture.errorMessage);

        expect(
          text.style.fontSize,
          Typography.englishLike2018.caption.fontSize,
        );
        expect(
          text.style.fontWeight,
          Typography.englishLike2018.caption.fontWeight,
        );
      },
    );
  });

  testWidgets(
    'should type in username, password, and submit them when '
    'sign in button is tapped',
    (tester) async {
      final uiDataFixture = ArculusSignInStaticUIData(
        usernameHint: 'Email or username',
        passwordHint: 'Password',
        signInButtonLabel: 'SIGN IN',
      );
      final stateFixture = ArculusSignInState(username: '', password: '');

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ArculusPasswordSignInBody(
            controller: controller,
            uiData: uiDataFixture,
            signInState: stateFixture,
          ),
        ),
      ));

      final usernameFieldFinder = find.byKey(Key('sign-in-username'));
      final passwordFieldFinder = find.byKey(Key('sign-in-password'));
      final signInButtomFinder = find.byKey(Key('sign-in-button'));

      await tester.enterText(usernameFieldFinder, 'test123@test.com');
      await tester.enterText(passwordFieldFinder, 'admin123*');
      await tester.tap(signInButtomFinder);

      verify(controller.onSignInPressed(any, 'test123@test.com', 'admin123*'))
          .called(1);
    },
  );

  group('signUp', () {
    testWidgets('should be displayed without question', (tester) async {
      final uiDataFixture = ArculusSignInStaticUIData(
        usernameHint: 'Email or username',
        passwordHint: 'Password',
        signInButtonLabel: 'SIGN IN',
        signUpActionLabel: 'Sign Up',
      );

      final stateFixture = ArculusSignInState();

      await tester.pumpWidget(MaterialApp(
        theme: ThemeData.from(
          colorScheme: ColorScheme.light(),
          textTheme: Typography.englishLike2018,
        ),
        home: Scaffold(
          body: ArculusPasswordSignInBody(
            controller: controller,
            uiData: uiDataFixture,
            signInState: stateFixture,
          ),
        ),
      ));

      expect(find.byKey(Key('sign-up-text-row')), findsNothing);
      expect(find.byKey(Key('sign-up-question')), findsNothing);
      final signUpActionFinder = find.byKey(Key('sign-up-action'));
      final signUpActionTextFinder = find
          .descendant(of: signUpActionFinder, matching: find.byType(Text))
          .first;
      final signUpActionText = tester.widget<Text>(signUpActionTextFinder);
      expect(signUpActionText.data, 'Sign Up');

      expect(
        signUpActionText.style.fontSize,
        Typography.englishLike2018.caption.fontSize,
      );
      expect(signUpActionText.style.fontWeight, FontWeight.bold);

      final paddingFinder = find.byKey(Key('sign-up-padding'));
      expect(paddingFinder, findsOneWidget);
      expect(tester.widget<Padding>(paddingFinder).padding,
          EdgeInsets.symmetric(vertical: 8));

      await tester.tap(signUpActionFinder);
      verify(controller.onSignUpPressed(any)).called(1);
    });
    testWidgets('should be displayed with question', (tester) async {
      final uiDataFixture = ArculusSignInStaticUIData(
        usernameHint: 'Email or username',
        passwordHint: 'Password',
        signInButtonLabel: 'SIGN IN',
        signUpActionLabel: 'Sign Up',
        signUpQuestionLabel: 'No account yet?',
      );

      final stateFixture = ArculusSignInState();

      await tester.pumpWidget(MaterialApp(
        theme: ThemeData.from(
          colorScheme: ColorScheme.light(),
          textTheme: Typography.englishLike2018,
        ),
        home: Scaffold(
          body: ArculusPasswordSignInBody(
            controller: controller,
            uiData: uiDataFixture,
            signInState: stateFixture,
          ),
        ),
      ));

      expect(find.byKey(Key('sign-up-text-row')), findsOneWidget);
      final signUpQuestionFinder = find.byKey(Key('sign-up-question'));
      final signUpQuestion = tester.widget<Text>(signUpQuestionFinder);

      expect(signUpQuestion.data, 'No account yet?' + ' ');

      final signUpActionFinder = find.byKey(Key('sign-up-action'));
      final signUpActionTextFinder = find
          .descendant(of: signUpActionFinder, matching: find.byType(Text))
          .first;
      final signUpActionText = tester.widget<Text>(signUpActionTextFinder);
      expect(signUpActionText.data, 'Sign Up');

      expect(
        signUpActionText.style.fontSize,
        Typography.englishLike2018.caption.fontSize,
      );
      expect(signUpActionText.style.fontWeight, FontWeight.bold);

      final paddingFinder = find.byKey(Key('sign-up-padding'));
      expect(paddingFinder, findsOneWidget);
      expect(tester.widget<Padding>(paddingFinder).padding,
          EdgeInsets.symmetric(vertical: 8));

      await tester.tap(signUpActionFinder);
      verify(controller.onSignUpPressed(any)).called(1);
    });
  });

  group('resetPassword', () {
    testWidgets('should be displayed without question', (tester) async {
      final uiDataFixture = ArculusSignInStaticUIData(
        usernameHint: 'Email or username',
        passwordHint: 'Password',
        signInButtonLabel: 'SIGN IN',
        resetPasswordActionLabel: 'Reset Your Password',
      );

      final stateFixture = ArculusSignInState();

      await tester.pumpWidget(MaterialApp(
        theme: ThemeData.from(
          colorScheme: ColorScheme.light(),
          textTheme: Typography.englishLike2018,
        ),
        home: Scaffold(
          body: ArculusPasswordSignInBody(
            controller: controller,
            uiData: uiDataFixture,
            signInState: stateFixture,
          ),
        ),
      ));

      expect(find.byKey(Key('reset-password-text-row')), findsNothing);
      expect(find.byKey(Key('reset-password-question')), findsNothing);
      final resetPasswordActionFinder =
          find.byKey(Key('reset-password-action'));
      final resetPasswordActionTextFinder = find
          .descendant(
              of: resetPasswordActionFinder, matching: find.byType(Text))
          .first;
      final resetPasswordActionText =
          tester.widget<Text>(resetPasswordActionTextFinder);
      expect(resetPasswordActionText.data, 'Reset Your Password');

      expect(
        resetPasswordActionText.style.fontSize,
        Typography.englishLike2018.caption.fontSize,
      );
      expect(resetPasswordActionText.style.fontWeight, FontWeight.bold);

      final paddingFinder = find.byKey(Key('reset-password-padding'));
      expect(paddingFinder, findsOneWidget);
      expect(tester.widget<Padding>(paddingFinder).padding,
          EdgeInsets.symmetric(vertical: 8));

      await tester.tap(resetPasswordActionFinder);
      verify(controller.onResetPasswordPressed(any)).called(1);
    });
    testWidgets('should be displayed with question', (tester) async {
      final uiDataFixture = ArculusSignInStaticUIData(
        usernameHint: 'Email or username',
        passwordHint: 'Password',
        signInButtonLabel: 'SIGN IN',
        resetPasswordActionLabel: 'Reset Your Password',
        resetPasswordQuestionLabel: 'Password forgotten?',
      );

      final stateFixture = ArculusSignInState();

      await tester.pumpWidget(MaterialApp(
        theme: ThemeData.from(
          colorScheme: ColorScheme.light(),
          textTheme: Typography.englishLike2018,
        ),
        home: Scaffold(
          body: ArculusPasswordSignInBody(
            controller: controller,
            uiData: uiDataFixture,
            signInState: stateFixture,
          ),
        ),
      ));

      expect(find.byKey(Key('reset-password-text-row')), findsOneWidget);
      final resetPasswordQuestionFinder =
          find.byKey(Key('reset-password-question'));
      final resetPasswordQuestion =
          tester.widget<Text>(resetPasswordQuestionFinder);

      expect(resetPasswordQuestion.data, 'Password forgotten?' + ' ');

      final resetPasswordActionFinder =
          find.byKey(Key('reset-password-action'));
      final resetPasswordActionTextFinder = find
          .descendant(
              of: resetPasswordActionFinder, matching: find.byType(Text))
          .first;
      final resetPasswordActionText =
          tester.widget<Text>(resetPasswordActionTextFinder);
      expect(resetPasswordActionText.data, 'Reset Your Password');

      expect(
        resetPasswordActionText.style.fontSize,
        Typography.englishLike2018.caption.fontSize,
      );
      expect(resetPasswordActionText.style.fontWeight, FontWeight.bold);

      final paddingFinder = find.byKey(Key('reset-password-padding'));
      expect(paddingFinder, findsOneWidget);
      expect(tester.widget<Padding>(paddingFinder).padding,
          EdgeInsets.symmetric(vertical: 8));

      await tester.tap(resetPasswordActionFinder);
      verify(controller.onResetPasswordPressed(any)).called(1);
    });
  });
}
