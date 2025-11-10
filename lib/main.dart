import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherAppRefita());
}

class WeatherAppRefita extends StatelessWidget {
  const WeatherAppRefita({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App Refita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({super.key});

  final List<Weather> weatherList = const [
    Weather(city: 'Jakarta', temp: 32, condition: WeatherCondition.sunny),
    Weather(city: 'Bandung', temp: 25, condition: WeatherCondition.cloudy),
    Weather(city: 'Surabaya', temp: 29, condition: WeatherCondition.rainy),
    Weather(city: 'Yogyakarta', temp: 27, condition: WeatherCondition.sunny),
    Weather(city: 'Medan', temp: 30, condition: WeatherCondition.cloudy),
    Weather(city: 'Bali', temp: 28, condition: WeatherCondition.sunny),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App - Refita Yunie',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF90CAF9), Color(0xFFE3F2FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth <= 600;
            final padding = EdgeInsets.all(isSmallScreen ? 10 : 16);

            if (isSmallScreen) {
              return ListView.builder(
                padding: padding,
                itemCount: weatherList.length,
                itemBuilder: (context, index) =>
                    WeatherCard(weather: weatherList[index]),
              );
            }

            return GridView.builder(
              padding: padding,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3,
              ),
              itemCount: weatherList.length,
              itemBuilder: (context, index) =>
                  WeatherCard(weather: weatherList[index]),
            );
          },
        ),
      ),
    );
  }
}

// ===== Model Cuaca =====
enum WeatherCondition { sunny, cloudy, rainy }

class Weather {
  final String city;
  final int temp;
  final WeatherCondition condition;

  const Weather({
    required this.city,
    required this.temp,
    required this.condition,
  });
}

// ===== Widget Card Cuaca =====
class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  IconData get icon {
    switch (weather.condition) {
      case WeatherCondition.sunny:
        return Icons.wb_sunny_rounded;
      case WeatherCondition.cloudy:
        return Icons.cloud_rounded;
      case WeatherCondition.rainy:
        return Icons.beach_access_rounded;
    }
  }

  Color get iconColor {
    switch (weather.condition) {
      case WeatherCondition.sunny:
        return Colors.orangeAccent;
      case WeatherCondition.cloudy:
        return Colors.blueGrey;
      case WeatherCondition.rainy:
        return Colors.lightBlueAccent;
    }
  }

  String get conditionText {
    switch (weather.condition) {
      case WeatherCondition.sunny:
        return 'Sunny';
      case WeatherCondition.cloudy:
        return 'Cloudy';
      case WeatherCondition.rainy:
        return 'Rainy';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      shadowColor: Colors.black26,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            Icon(icon, size: 50, color: iconColor),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weather.city,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    conditionText,
                    style: TextStyle(
                      fontSize: 16,
                      color: iconColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${weather.temp}°C',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
