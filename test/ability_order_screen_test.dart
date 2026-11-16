import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eqi30/features/abilities/ability_order_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('AbilityOrderScreen renders ability cards properly with non-wrapped titles', (tester) async {
    SharedPreferences.setMockInitialValues({
      'onboarding_session_id': 'mock_session_id',
      'selected_growth_plan': 'LOW',
    });

    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: AbilityOrderScreen(isOnboarding: true),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Prioritize Your 30 Abilities'), findsOneWidget);
    expect(find.text('Emotional Awareness'), findsWidgets);

    // Verify the title text is properly sized and not collapsed to 1-char width
    final titleFinder = find.text('Emotional Awareness').first;
    final titleSize = tester.getSize(titleFinder);
    expect(titleSize.width, greaterThan(100.0));

    // Verify AI Pick and Today badge exist
    expect(find.text('Today'), findsWidgets);
    expect(find.text('+ Pick'), findsWidgets);
  });
}

