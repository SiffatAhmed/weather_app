import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/src/core/shared/shared_services.dart';
import 'package:weather_app/src/features/weather/models/weather_model.dart';

class NetworkCalls {
  Future<WeatherResponse?>? networkCallWithOutToken(Map<dynamic, dynamic> data) async {
    Response<dynamic>? response;
    await dotenv.load(fileName: ".env");
    log(dotenv.env.toString());
    try {
      final dio = Dio(BaseOptions(baseUrl: "https://api.openweathermap.org"));
      final Map<String, dynamic> queryParameters = {
        'lat': data["lat"],
        'lon': data["lon"],
        'appid': dotenv.env['OPENWEATHER_API_KEY'],
      };
      response = await dio.get("/data/3.0/onecall?", queryParameters: queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String? currentCity = await SharedServices().getCity(queryParameters["lat"], queryParameters["lon"]);
        return WeatherResponse.fromJson({
          ...response.data,
          'city': currentCity ?? 'Islamabad',
        });
      }
    } on HttpException {
      throw const HttpException('Failed to load data from the server');
    } on FormatException {
      throw const FormatException('Bad response format');
    } on SocketException {
      throw const SocketException('No Internet connection');
    } on DioException catch (e) {
      var response = e.response;
      if (response != null) {
        throw response.data.toString();
      } else {
        throw 'Unexpected error';
      }
    } catch (e) {
      throw 'Unexpected error';
    }
    return null;
  }
}
