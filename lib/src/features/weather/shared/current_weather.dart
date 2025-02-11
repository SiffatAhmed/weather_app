import 'package:flutter/material.dart';
import 'package:weather_app/src/core/shared/globals.dart';
import 'package:weather_app/src/features/weather/models/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({
    super.key,
    required this.data,
  });

  final WeatherResponse data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Today's forecast",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Card(
          elevation: 5,
          child: Padding(
            padding: cardPadding,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WeatherPoint(
                      icon: WeatherIcons.thermometer,
                      text: "Temperature: ${(data.current.temp - 273.15).toInt()} °C",
                    ),
                    const SizedBox(height: 8),
                    WeatherPoint(
                      icon: WeatherIcons.humidity,
                      text: "Humidity: ${data.current.humidity}",
                    ),
                    const SizedBox(height: 8),
                    WeatherPoint(
                      icon: WeatherIcons.wind_direction,
                      text: "Wind Speed: ${data.current.windSpeed}",
                    ),
                  ],
                ),
                const Spacer(),
                WeatherStatusWithIcon(
                    weatherTitle: data.current.weather[0].main, weatherIcon: data.current.weather[0].icon, precipitation: "Precipitation: ${data.current.clouds / 100}%"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WeatherStatusWithIcon extends StatelessWidget {
  const WeatherStatusWithIcon({
    super.key,
    required this.weatherTitle,
    required this.weatherIcon,
    required this.precipitation,
  });

  final String weatherTitle;
  final String weatherIcon;
  final String precipitation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            weatherTitle,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Image.network(
            "http://openweathermap.org/img/wn/$weatherIcon.png",
            loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : const CircularProgressIndicator(),
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          ),
          Text(
            precipitation,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}

class WeatherPoint extends StatelessWidget {
  const WeatherPoint({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
