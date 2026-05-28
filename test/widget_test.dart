import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:objectbox_atv/main.dart';

import 'fake_adventurer_controller.dart';

void main() {
  testWidgets('Teste de fumaça da Taverna RPG', (WidgetTester tester) async {
    final fakeController = FakeAdventurerController();

    await tester.pumpWidget(RpgApp(controller: fakeController));

    expect(find.text('Grupo de Aventureiros'), findsOneWidget);

    expect(find.text('Nenhum aventureiro recrutado ainda.'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));

    await tester.pumpAndSettle();

    expect(find.text('Novo Aventureiro'), findsOneWidget);
    expect(find.text('Nome'), findsOneWidget);
  });
}
