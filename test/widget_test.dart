// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ilearn/main.dart';
import 'package:ilearn/core/network/dio_client.dart';
import 'package:ilearn/data/datasources/local/auth_local_datasource.dart';
import 'package:ilearn/data/datasources/remote/auth_remote_datasource.dart';
import 'package:ilearn/data/repositories/auth_repository.dart';

void main() {
  testWidgets('App initializes correctly', (WidgetTester tester) async {
    // Initialize SharedPreferences for testing
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // Setup dependencies
    final dioClient = DioClient();
    final authRemoteDataSource = AuthRemoteDataSource(dioClient);
    final authLocalDataSource = AuthLocalDataSource(prefs);
    final authRepository = AuthRepository(
      authRemoteDataSource,
      authLocalDataSource,
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(authRepository: authRepository));

    // Wait for any async operations
    await tester.pumpAndSettle();

    // Verify that the app loads (can add more specific checks)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
