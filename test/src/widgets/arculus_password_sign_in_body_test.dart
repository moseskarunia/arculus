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
    testWidgets(
      'should assign provided username and password state to their '
      'respective text fields',
      (tester) async {},
    );
    testWidgets(
      'should display provided errorMessage if provided',
      (tester) async {},
    );
    testWidgets(
      'when isLoading, should disable text fields and display loading indicator',
      (tester) async {},
    );
    testWidgets(
      'when ',
      (tester) async {},
    );
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
}
