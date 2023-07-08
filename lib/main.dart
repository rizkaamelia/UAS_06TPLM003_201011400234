import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String apiKey = '4dcd380a99018a6d9f08ce499772837e';
  String city = 'Jakarta';
  String weather = '';
  String temperature = '';
  String formattedDate = '';
  String day = '';

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey');
    final response = await http.get(url);
    final data = json.decode(response.body);
    final mainWeather = data['weather'][0]['main'];
    final temp = data['main']['temp'];
    final tempInCelsius = (temp - 273.15).toStringAsFixed(1);
    final date = DateTime.now();
    final formatted = DateFormat.yMMMMd().format(date);
    final dayOfWeek = DateFormat.E().format(date);

    setState(() {
      weather = mainWeather;
      temperature = tempInCelsius;
      formattedDate = formatted;
      day = dayOfWeek;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://www.pixelstalk.net/wp-content/uploads/2016/07/Download-Free-Weather-Background.jpg'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.lightBlueAccent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                city,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '$day, $formattedDate',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '$temperature °c',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '---------------',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '$weather',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '25°c / 28°c',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
