import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Mente Viva app starts on the loading screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Mente Viva'), findsOneWidget);
    expect(find.text('CARREGANDO...'), findsOneWidget);
  });
}
