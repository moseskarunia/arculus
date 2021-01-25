import 'package:arculus/arculus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Outer container', () {
    testWidgets('should use default values', (tester) async {
      await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: ArculusOnboardingBody())));

      final container = find.byKey(Key('arculus-onboarding-body'));

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

      final container = find.byKey(Key('arculus-onboarding-body'));

      expect(container, findsOneWidget);
      expect(tester.getSize(container).width, 100);
      expect(tester.widget<Container>(container).padding, EdgeInsets.all(32));
      expect(
        find.ancestor(of: container, matching: find.byType(Scaffold)),
        findsOneWidget,
      );
    });
  });

  testWidgets('should show branding widget if provided', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ArculusOnboardingBody(
            padding: EdgeInsets.all(32),
            branding: Container(key: Key('branding'), width: 100, height: 100),
          ),
        ),
      ),
    );

    final branding = find.byKey(Key('branding'));

    expect(branding, findsOneWidget);
    expect(find.ancestor(of: branding, matching: find.byType(Expanded)),
        findsOneWidget);
  });

  testWidgets('should show buttons at the bottom', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ArculusOnboardingBody(
            buttons: [
              RaisedButton(key: Key('first-button'), onPressed: () {}),
              RaisedButton(key: Key('second-button'), onPressed: () {}),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle(Duration(milliseconds: 100));

    final brandingArea = find.byKey(Key('branding-area'));
    final firstButton = find.byKey(Key('first-button'));
    final secondButton = find.byKey(Key('second-button'));

    final ancestorOfBrandingArea = find.ancestor(
        of: brandingArea, matching: find.byKey(Key('main-column')));
    final ancestorOfFirstButton = find.ancestor(
        of: firstButton, matching: find.byKey(Key('main-column')));
    final ancestorOfSecondButton = find.ancestor(
        of: secondButton, matching: find.byKey(Key('main-column')));

    expect(tester.widget(brandingArea).runtimeType, Expanded);
    expect(firstButton, findsOneWidget);
    expect(secondButton, findsOneWidget);
    expect(ancestorOfBrandingArea, findsOneWidget);
    expect(ancestorOfFirstButton, findsOneWidget);
    expect(ancestorOfSecondButton, findsOneWidget);
  });
}
