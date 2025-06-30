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
    return SizedBox(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Padding(
          padding: cardPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                intl.DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(hourlyWeather.dt * 1000)),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                    ),
              ),
              Row(
                children: [
                  Text(
                    "${(hourlyWeather.temp - 273.15).toInt()} °C",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 1.2,
                    child: WeatherStatusWithIcon(
                      weatherTitle: null,
                      weatherIcon: hourlyWeather.weather[0].icon,
                      precipitation: "",
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.water_drop,
                    size: 20,
                  ),
                  Text(
                    "${hourlyWeather.humidity}",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const Text(' => '),
                  const Icon(
                    Icons.air,
                    size: 20,
                  ),
                  Text(
                    " ${hourlyWeather.windSpeed} km/h",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.visibility,
                    size: 20,
                  ),
                  Text(
                    "${hourlyWeather.visibility ~/ 1000}%",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
