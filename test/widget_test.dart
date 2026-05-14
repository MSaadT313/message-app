import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:message_app_flutter/main.dart';
import 'package:message_app_flutter/themes/theme_provider.dart';

void main() {

  testWidgets(
    'App builds successfully',
        (WidgetTester tester) async {

      await tester.pumpWidget(

        ChangeNotifierProvider(

          create: (_) => ThemeProvider(),

          child: const MyApp(),
        ),
      );

      // Verify MaterialApp exists
      expect(find.byType(MaterialApp), findsOneWidget);
    },
  );
}