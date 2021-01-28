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
      'should be wrapped in container with 32 bottom margin',
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
      },
    );
  });
}
