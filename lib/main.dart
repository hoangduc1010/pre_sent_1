import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isProduction = appFlavor == 'production';

    final apiUrl = isProduction
        ? 'https://api.example.com'
        : 'https://dev-api.example.com';

    return MaterialApp(
      title: isProduction ? 'My App' : 'My App Dev',
      home: Scaffold(
        appBar: AppBar(
          title: Text(isProduction ? 'Production' : 'Development'),
        ),
        body: Center(
          child: Text('API: $apiUrl'),
        ),
      ),
    );
  }
}
// flutter run -d chrome --flavor development
// flutter run -d chrome --flavor production