import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor:Colors.black),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
