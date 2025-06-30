import 'package:flutter/material.dart';
import 'package:weather_app/src/core/shared/globals.dart';
import 'package:weather_app/src/core/shared/shared_services.dart';
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
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white,
      child: Padding(
        padding: cardPadding,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                SharedServices().formattedDate(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    WeatherPoint(
                      icon: null,
                      text: "${(data.current.temp - 273.15).toInt()} °C",
                    ),
                    const Spacer(),
                    WeatherStatusWithIcon(
                        weatherTitle: data.current.weather[0].main, weatherIcon: data.current.weather[0].icon, precipitation: " ${data.current.visibility} meters"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    WeatherPoint(
                      icon: WeatherIcons.humidity,
                      text: "Humidity: ${data.current.humidity}",
                    ),
                    const Spacer(),
                    const SizedBox(height: 8),
                    WeatherPoint(
                      icon: WeatherIcons.wind_direction,
                      text: "Wind Speed: ${data.current.windSpeed}",
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                WeatherPoint(
                  icon: Icons.visibility,
                  text: "Precipitation: ${data.current.visibility ~/ 1000} km",
                ),
              ],
            ),
          ],
        ),
      ),
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

  final String? weatherTitle;
  final String weatherIcon;
  final String precipitation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          "http://openweathermap.org/img/wn/$weatherIcon.png",
          height: 80,
          width: 80,
          loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : const CircularProgressIndicator(),
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
        if (weatherTitle != null) ...[
          const SizedBox(height: 8),
          Text(
            weatherTitle!,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
          ),
        ],
      ],
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
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[Icon(icon), const SizedBox(width: 8)],
        Text(
          text,
          style: icon == null ? Theme.of(context).textTheme.displayMedium : Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
