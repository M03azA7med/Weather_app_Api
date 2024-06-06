import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/current_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      backgroundColor: Color(0xff030317),
      body: SafeArea(
        child: Column(
          children: [
            CurrentWeather()
          ],
        ),
      ),

    );
  }
}
