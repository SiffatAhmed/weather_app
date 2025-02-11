import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/features/weather/bloc/weather_bloc.dart';
import 'package:weather_app/src/features/weather/models/weather_model.dart';
import 'package:weather_app/src/features/weather/views/weather_view.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    BlocProvider.of<WeatherBloc>(context).add(FetchWeatherEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, WeatherState state) {
      switch (state.runtimeType) {
        case const (WeatherLoaded):
          WeatherResponse data = (state as WeatherLoaded).response;
          return WeatherView(data: data);

        case const (WeatherLoading):
          return const Center(
            child: CircularProgressIndicator(),
          );
        case const (WeatherError):
          return Center(
            child: Text((state as WeatherError).message),
          );
        default:
          return const Text('Some thing went wrong');
      }
    }));
  }
}
