import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛠️ Debug Tools'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '⚠️ Developer Tools',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Các công cụ debug cho developer',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Clear Cache Button
            ElevatedButton.icon(
              onPressed: () async {
                context.read<AuthBloc>().add(const LogoutRequested());

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Đã xóa tất cả cache (SharedPreferences)!'),
                    backgroundColor: Colors.green,
                  ),
                );

                await Future.delayed(const Duration(seconds: 1));
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.delete_forever),
              label: const Text('🗑️ Xóa Cache (SharedPreferences)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),

            const SizedBox(height: 20),

            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ℹ️ Thông tin',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('• SharedPreferences lưu token LOCAL'),
                    Text('• Tồn tại mãi mãi cho đến khi xóa'),
                    Text('• Không liên quan đến backend'),
                    Text('• Click nút trên để xóa toàn bộ'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
