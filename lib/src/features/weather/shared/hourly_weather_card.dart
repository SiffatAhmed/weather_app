import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:weather_app/src/core/shared/globals.dart';
import 'package:weather_app/src/features/weather/models/weather_model.dart';
import 'package:weather_app/src/features/weather/shared/current_weather.dart';

class HourlyWeatherCard extends StatelessWidget {
  const HourlyWeatherCard({super.key, required this.hourlyWeather});
  final HourlyWeather hourlyWeather;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: cardPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Date: ${intl.DateFormat('dd/MM').format(DateTime.fromMillisecondsSinceEpoch(hourlyWeather.dt * 1000))}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              "Time: ${intl.DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(hourlyWeather.dt * 1000))}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              "Temperature: ${(hourlyWeather.temp - 273.15).toInt()} °C",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              "Humidity: ${hourlyWeather.humidity}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              "Wind Speed: ${hourlyWeather.windSpeed}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            WeatherStatusWithIcon(
              weatherTitle: hourlyWeather.weather[0].main,
              weatherIcon: hourlyWeather.weather[0].icon,
              precipitation: "Precipitation: ${hourlyWeather.clouds / 100}%",
            ),
          ],
        ),
      ),
    );
  }
}
