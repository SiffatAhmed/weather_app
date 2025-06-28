import 'dart:developer';

import 'package:fl_location/fl_location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/core/network/network_calls.dart';
import 'package:weather_app/src/core/shared/globals.dart';
import 'package:weather_app/src/core/shared/shared_services.dart';
import 'package:weather_app/src/features/weather/models/weather_model.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeatherEvent>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoading());
      Location? location;
      LocationPermission? locationPermission;
      Location position;
      print('crossed requestPermission');
      if (event.cityName != null) {
        log(event.cityName.toString());
        var res = await SharedServices().getLocation(event.cityName!);
        log("${res.latitude}\n${res.longitude}");
        position = Location.fromJson({
          "longitude": res.longitude,
          "latitude": res.latitude,
        });
      } else {
        locationPermission = await FlLocation.checkLocationPermission();
        if (locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever) {
          locationPermission = await FlLocation.requestLocationPermission();
          position = Location.fromJson(defaultPosition);
        }

        if (locationPermission == LocationPermission.always || locationPermission == LocationPermission.whileInUse) {
          try {
            if (await FlLocation.isLocationServicesEnabled) {
              var res = await FlLocation.getLocation();
              position = res;
            } else {
              position = Location.fromJson(defaultPosition);
            }
          } catch (e) {
            position = Location.fromJson(defaultPosition);
          }
        } else {
          position = Location.fromJson(defaultPosition);
        }
      }
      print(position.toJson().toString());

      var weatherResponse = await NetworkCalls().networkCallWithOutToken({"lat": position.latitude, "lon": position.longitude});
      if (weatherResponse != null) {
        emit(WeatherLoaded(weatherResponse));
      }
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}

abstract class WeatherEvent {}

class FetchWeatherEvent extends WeatherEvent {
  final String? cityName;

  FetchWeatherEvent({this.cityName});

  @override
  List<String?> get props => [cityName];
}

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherResponse response;

  WeatherLoaded(this.response);
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}
