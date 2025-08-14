import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/model/weatherModel.dart';

class Weatherwidget extends StatelessWidget {
  final WeatherModel weather;
  const Weatherwidget({super.key, required this.weather});
  String formatTIme(int timestemp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestemp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              LottieBuilder.asset(
                weather.description.contains('rain')
                    ? 'assets/rain.json'
                    : weather.description.contains("sunny")
                    ? 'assets/sunny.json'
                    : weather.description.contains('snowfall')
                    ? 'assets/snowfall.json'
                    : "assets/cloudy.json",

                height: 150,
                width: 150,
              ),
              Text(
                weather.cityName,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 8),
              Text(
                "${weather.temparature.toStringAsFixed(1)}°C",
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                weather.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Humidity :${weather.humidity} %",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Wind ${weather.windSpeed} n/s",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.wb_sunny_outlined),
                      Text(
                        "Sunrise",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        formatTIme(weather.sunrise),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  SizedBox(width: 15),
                  Column(
                    children: [
                      Icon(Icons.nights_stay_outlined),
                      Text(
                        "Sunset",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        formatTIme(weather.sunset),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
