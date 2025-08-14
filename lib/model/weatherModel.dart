class WeatherModel {
  final String cityName;
  final double temparature;
  final String description;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;

  WeatherModel({
    required this.cityName,
    required this.description,
    required this.temparature,
    required this.humidity,
    required this.windSpeed,
    required this.sunset,
    required this.sunrise,
  });

  factory WeatherModel.fromjson(Map<String, dynamic> weather) {
    return WeatherModel(
      cityName: weather['name'],
      description: weather['weather'][0]['description'],
      temparature: weather['main']['temp'] - 273.15,
      humidity: weather['main']['humidity'],
      windSpeed: weather['wind']['speed'],
      sunset: weather['sys']['sunset'],
      sunrise: weather['sys']['sunrise'],
    );
  }
}
