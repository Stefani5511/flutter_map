import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_obter_posicao_map/main.dart';

void main() {
  testWidgets('exibe a tela do mapa', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Obter Coordenadas (flutter_map)'), findsOneWidget);
    expect(
      find.text('Toque em um ponto do mapa para obter as coordenadas.'),
      findsOneWidget,
    );
  });
}
