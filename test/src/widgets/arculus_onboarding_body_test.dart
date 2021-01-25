import 'package:arculus/arculus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Outer container', () {
    testWidgets('should use default values', (tester) async {
      await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: ArculusOnboardingBody())));

      final container = find.byKey(Key('arculus_onboarding_body'));

      expect(container, findsOneWidget);
      expect(
        tester.getSize(container).width,
        WidgetsBinding.instance.renderView.configuration.size.width,
      );
      expect(tester.widget<Container>(container).padding, EdgeInsets.zero);
      expect(find.ancestor(of: container, matching: find.byType(Scaffold)),
          findsOneWidget);
    });
    testWidgets('should use provided values', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ArculusOnboardingBody(
              width: 100,
              padding: EdgeInsets.all(32),
            ),
          ),
        ),
      );

      final container = find.byKey(Key('arculus_onboarding_body'));

      expect(container, findsOneWidget);
      expect(tester.getSize(container).width, 100);
      expect(tester.widget<Container>(container).padding, EdgeInsets.all(32));
      expect(
        find.ancestor(of: container, matching: find.byType(Scaffold)),
        findsOneWidget,
      );
    });
  });
}
