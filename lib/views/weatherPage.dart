import 'package:flutter/material.dart';
import 'package:quran/containts/Containts.dart';
import 'package:quran/controller/weatherController.dart';
import 'package:quran/model/weatherModel.dart';
import 'package:quran/widget/weatherWidget.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  TextEditingController _controller = TextEditingController();
  final WeatherController _weatherController = WeatherController();
  WeatherModel? _weatherModel;
  bool isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherModel;
  }

  void _getWeatherData() async {
    setState(() {
      isloading = true;
    });
    try {
      final weather = await _weatherController.getWeather(
        _controller.text.trim(),
      );
      setState(() {
        _weatherModel = weather;
        isloading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Containts.secondaryColor,
        title: Text("Weather Apps", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: () {
            if (_weatherModel == null) {
              return LinearGradient(
                colors: [Colors.blueGrey, Colors.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              );
            }
            ;
            final weather = _weatherModel!.description.toLowerCase();
            if (weather.contains('rain')) {
              return LinearGradient(
                colors: [Colors.grey, Colors.blueGrey],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              );
            } else if (weather.contains('clear')) {
              return LinearGradient(
                colors: [
                  Colors.yellow,
                  const Color.fromARGB(255, 235, 184, 109),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              );
            } else {
              return LinearGradient(
                colors: [Colors.blueGrey, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              );
            }
          }(),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter the city name",
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    _getWeatherData();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                  child: Text(
                    "Show the weather",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                if (isloading)
                  Padding(
                    padding: EdgeInsetsGeometry.all(8),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                if (_weatherModel != null)
                  Weatherwidget(weather: _weatherModel!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
