import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

import 'data_model.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({super.key});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  final TextEditingController _cityController = TextEditingController();
  WeatherModel? _weatherData;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: GestureDetector(
          child: GlowContainer(
            height: MediaQuery.of(context).size.height - 200,
            margin: EdgeInsets.all(3),
            spreadRadius: 0.5,
            padding: EdgeInsets.all(10),
            glowColor: Colors.white,
            color: Colors.deepOrange,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50)),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Color(0xffffffff)),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: _cityController,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      hintText: 'Enter city name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.map_fill,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Weather App",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      Image(
                        image: AssetImage('assets/sunny.png'),
                        fit: BoxFit.fill,
                      ),

                    ],
                  ),
                ),
                if (_weatherData != null)
                  Column(
                    children: [
                      Text('${_weatherData!.cityName}',style: TextStyle(
                        color: Colors.white
                      ),),
                      GlowText(
                        '${_weatherData!.temperature}°C',
                        style: TextStyle(fontSize: 24,color: Colors.white),
                      ),
                      Text(_weatherData!.description,style: TextStyle(
                        color: Colors.white,
                        fontSize:20
                      ),),
                      Image.network('http://openweathermap.org/img/wn/${_weatherData?.icon}.png',fit: BoxFit.fill),
                    ],
                  ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final cityName = _cityController.text;
                        final weatherData =
                        await WeatherService().getWeatherData(cityName);
                        if (weatherData != null) {
                          setState(() {
                            _weatherData = weatherData;
                          });
                        }
                        else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text('Error fetching weather data',style: TextStyle(color: Colors.white),),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('ok'))
                                ],
                                backgroundColor: Colors.black,
                              );
                            },
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('invalid city name')),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('An error occurred: $e')),
                        );
                      }
                    },
                    child: Text('Get Weather'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
