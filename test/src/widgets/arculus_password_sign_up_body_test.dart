import 'package:arculus/src/widgets/arculus_password_sign_up_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockController extends Mock implements ArculusPasswordSignUpController {}

void main() {
  final uiDataFixture = ArculusSignUpStaticUIData(
    usernameHint: 'Enter email',
    passwordHint: 'Enter password',
    retypedPasswordHint: 'Retype entered password',
    signUpButtonLabel: 'Sign Up',
  );

  MockController controller;

  setUp(() {
    controller = MockController();
  });

  Future<void> _setUpEnvironment(WidgetTester tester,
      {@required ArculusSignUpState state}) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ArculusPasswordSignUpBody(
            uiData: uiDataFixture,
            controller: controller,
            signUpState: state,
          ),
        ),
      ),
    );
  }

  Future<void> _testTextField(
    WidgetTester tester, {
    Key key,
    String hint,
    String value,
    EdgeInsetsGeometry margin,
    bool isPassword = false,
    bool enabled = true,
  }) async {
    final fieldFinder = find.byKey(key);
    final outerContainer =
        find.ancestor(of: fieldFinder, matching: find.byType(Container)).first;
    final tfWidget = tester.widget<TextField>(fieldFinder);

    if (isPassword) {
      expect(tfWidget.obscureText, true);
    }

    expect(tester.widget<Container>(outerContainer).margin, margin);
    expect(tfWidget.decoration.hintText, hint);
    expect(tfWidget.controller.text, value);
    expect(tfWidget.enabled, enabled);
  }

  Future<void> _testButton(
    WidgetTester tester, {
    Key key,
    bool enabled = true,
  }) async {
    final buttonFinder = find.byKey(key);
    final buttonWidget = tester.widget<ElevatedButton>(buttonFinder);

    final outerContainer =
        find.ancestor(of: buttonFinder, matching: find.byType(Container)).first;

    final buttonTextFinder =
        find.descendant(of: buttonFinder, matching: find.byType(Text)).first;
    final text = tester.widget<Text>(buttonTextFinder);

    expect(
      tester.widget<Container>(outerContainer).margin,
      EdgeInsets.only(bottom: 16),
    );
    expect(text.data, uiDataFixture.signUpButtonLabel);
    expect(buttonWidget.enabled, enabled);
  }

  group('ArculusSignUpState', () {
    test('props', () {
      final s = ArculusSignUpState(
        errorMessage: 'TEST',
        isLoading: true,
        password: 'admin123*',
        retypedPassword: 'admin',
        username: 'test@test.com',
      );

      expect(s.props, ['TEST', true, 'admin123*', 'admin', 'test@test.com']);
    });
  });

  group('root ListView', () {
    testWidgets('should use provided padding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ArculusPasswordSignUpBody(
              uiData: uiDataFixture,
              controller: controller,
              padding: const EdgeInsets.all(16),
            ),
          ),
        ),
      );

      final rootListViewFinder = find.byKey(Key('sign-up-root-list-view'));
      expect(
        tester.widget<ListView>(rootListViewFinder).padding,
        const EdgeInsets.all(16),
      );
    });
    testWidgets('should use default padding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ArculusPasswordSignUpBody(
              uiData: uiDataFixture,
              controller: controller,
            ),
          ),
        ),
      );

      final rootListViewFinder = find.byKey(Key('sign-up-root-list-view'));
      expect(
        tester.widget<ListView>(rootListViewFinder).padding,
        const EdgeInsets.symmetric(vertical: 16),
      );
    });
  });
  group('when !state.isLoading,', () {
    final stateFixture = const ArculusSignUpState(
      password: 'admin123*',
      retypedPassword: 'admin',
      username: 'test@test.com',
    );
    testWidgets(
      'username textfield should display provided hint and enabled '
      'with 16 bottom margin',
      (tester) async {
        await _setUpEnvironment(tester, state: stateFixture);
        _testTextField(
          tester,
          key: Key('sign-up-username-field'),
          hint: uiDataFixture.usernameHint,
          margin: EdgeInsets.only(bottom: 16),
          value: stateFixture.username,
        );
      },
    );

    testWidgets(
      'password textfield should display provided hint and enabled '
      'with 16 bottom margin',
      (tester) async {
        await _setUpEnvironment(tester, state: stateFixture);

        _testTextField(
          tester,
          key: Key('sign-up-password-field'),
          hint: uiDataFixture.passwordHint,
          margin: EdgeInsets.only(bottom: 16),
          value: stateFixture.password,
          isPassword: true,
        );
      },
    );

    testWidgets(
      'retyped password textfield should display provided hint, enabled, '
      'and with 16 bottom margin',
      (tester) async {
        await _setUpEnvironment(tester, state: stateFixture);

        _testTextField(
          tester,
          key: Key('sign-up-retyped-password-field'),
          hint: uiDataFixture.retypedPasswordHint,
          margin: EdgeInsets.only(bottom: 32),
          value: stateFixture.retypedPassword,
          isPassword: true,
        );
      },
    );

    testWidgets(
      'sign up button should display provied label, enabled, '
      'and with 16 bottom margin.',
      (tester) async {
        await _setUpEnvironment(tester, state: stateFixture);
        _testButton(tester, key: Key('sign-up-button'));
      },
    );
  });

  group('when state.isLoading,', () {
    final stateFixture = const ArculusSignUpState(
      password: 'admin123*',
      retypedPassword: 'admin',
      username: 'test@test.com',
      isLoading: true,
    );
    testWidgets(
      'username textfield should display provided hint and !enabled '
      'with 16 bottom margin',
      (tester) async {
        await _setUpEnvironment(tester, state: stateFixture);
        _testTextField(
          tester,
          key: Key('sign-up-username-field'),
          hint: uiDataFixture.usernameHint,
          margin: EdgeInsets.only(bottom: 16),
          value: stateFixture.username,
          enabled: false,
        );
      },
    );

    testWidgets(
      'password textfield should display provided hint and enabled '
      'with 16 bottom margin',
      (tester) async {
        await _setUpEnvironment(tester, state: stateFixture);

        _testTextField(
          tester,
          key: Key('sign-up-password-field'),
          hint: uiDataFixture.passwordHint,
          margin: EdgeInsets.only(bottom: 16),
          value: stateFixture.password,
          isPassword: true,
          enabled: false,
        );
      },
    );

    testWidgets(
      'retyped password textfield should display provided hint, enabled, '
      'and with 16 bottom margin',
      (tester) async {
        await _setUpEnvironment(tester, state: stateFixture);

        _testTextField(
          tester,
          key: Key('sign-up-retyped-password-field'),
          hint: uiDataFixture.retypedPasswordHint,
          margin: EdgeInsets.only(bottom: 32),
          value: stateFixture.retypedPassword,
          isPassword: true,
          enabled: false,
        );
      },
    );

    testWidgets(
      'sign up button should display provied label, enabled, '
      'and with 16 bottom margin.',
      (tester) async {
        await _setUpEnvironment(tester, state: stateFixture);
        _testButton(tester, key: Key('sign-up-button'), enabled: false);
      },
    );
  });

  group('when state.errorMessage', () {
    testWidgets(
      'is provided, should be displayed under the button',
      (tester) async {
        //
      },
    );

    testWidgets(
      'is not provided, should not be visible',
      (tester) async {
        //
      },
    );
  });
}
