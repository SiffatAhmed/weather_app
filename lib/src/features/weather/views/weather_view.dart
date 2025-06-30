import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/src/core/shared/globals.dart';
import 'package:weather_app/src/features/weather/bloc/weather_bloc.dart';
import 'package:weather_app/src/features/weather/models/weather_model.dart';
import 'package:weather_app/src/features/weather/shared/current_weather.dart';
import 'package:weather_app/src/features/weather/shared/hourly_weather_card.dart';
import 'package:weather_app/src/features/weather/shared/search_field.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({
    super.key,
    required this.data,
  });

  final WeatherResponse data;

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  TextEditingController searchController = TextEditingController();
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  CameraPosition? pin;

  @override
  void initState() {
    pin = CameraPosition(
      target: LatLng(widget.data.lat, widget.data.lon),
      zoom: 14.4746,
    );
    super.initState();
  }

  @override
  void dispose() {
    mapController.future.then((value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: windowPadding,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("City ${widget.data.city}"),
                      const SizedBox(width: 10),
                      const Icon(Icons.my_location_sharp),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SearchField(
                    controller: searchController,
                    labelText: 'Search...',
                    hintText: 'Search...',
                    onChanged: (p0) {},
                    onSearch: () {
                      BlocProvider.of<WeatherBloc>(context).add(FetchWeatherEvent(cityName: searchController.text));
                    },
                    borderRadius: 80,
                    showIcon: true,
                  ),
                  const SizedBox(height: 10),
                  CurrentWeatherCard(data: widget.data),
                  SizedBox(height: 10.h),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.25,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: pin!,
                      onMapCreated: (controller) {
                        mapController.complete(controller);

                        setState(() {});
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId(UniqueKey().toString()),
                          position: LatLng(widget.data.lat, widget.data.lon),
                        )
                      },
                    ),
                  ),
                  widget.data.hourly.isNotEmpty
                      ? SizedBox(
                          height: 160.h,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Hourly Weather",
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (context, index) => SizedBox(width: 10.w),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.data.hourly.take(12).length,
                                  itemBuilder: (context, index) {
                                    return HourlyWeatherCard(hourlyWeather: widget.data.hourly[index]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
