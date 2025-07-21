import 'package:flutter_test/flutter_test.dart';
import 'package:nursery/main.dart'; // Keep this import

void main() {
  testWidgets('Splash Screen UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the splash screen shows the welcome message.
    // We use `find.textContaining` because the full text is in a RichText widget.
    expect(find.textContaining('Welcome to Sproutly'), findsOneWidget);

    // Verify that the "Start Planting" button is present.
    expect(find.text('Start Planting'), findsOneWidget);
  });
}
