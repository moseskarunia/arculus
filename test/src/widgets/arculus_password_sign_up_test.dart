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
}
