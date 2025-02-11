import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/src/features/weather/bloc/weather_bloc.dart';
import 'package:weather_app/src/features/weather/views/weather_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: false,
      enableScaleText: () => false,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => WeatherBloc())],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather app',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
              useMaterial3: false,
            ),
            home: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
              child: const WeatherPage(),
            ),
          ),
        );
      },
    );
  }
}
