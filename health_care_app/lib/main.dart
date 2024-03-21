import 'package:flutter/material.dart';

import 'pages/signIn.dart';
import 'test/app_screen_time.dart';
import 'utils/dashboard_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: UserDashBoard(),
    );
  }
}

