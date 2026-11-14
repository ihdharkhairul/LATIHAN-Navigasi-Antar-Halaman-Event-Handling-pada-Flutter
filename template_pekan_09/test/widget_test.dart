import 'package:flutter_test/flutter_test.dart';
import 'package:template_dppb/main.dart';

void main() {
  testWidgets('Hello World basic smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Halo Dunia DPPB Kota Bandung'), findsOneWidget);
  });
}
