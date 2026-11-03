import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Mente Viva app starts on the loading screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Mente Viva'), findsOneWidget);
    expect(find.text('CARREGANDO...'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Quem está usando o aplicativo?'), findsOneWidget);

    await tester.tap(find.text('Pessoa Assistida'));
    await tester.pumpAndSettle();
    expect(find.text('Início'), findsWidgets);
    expect(find.text('Lembretes'), findsWidgets);
  });
}
