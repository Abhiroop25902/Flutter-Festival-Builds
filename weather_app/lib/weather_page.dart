import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/weather_info.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key, required this.weatherInfo}) : super(key: key);

  final WeatherInfo weatherInfo;

  Widget _weatherRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('${weatherInfo.tempC}',
          style:
              GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 80))),
      Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Text('°C',
            style:
                GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 50))),
      ),
      Image.network(
        weatherInfo.iconUrl,
        scale: 0.6,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimeWidget(initialLocalTime: weatherInfo.localTime),
              _weatherRow(),
              Text('${weatherInfo.name}, ${weatherInfo.region}',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(fontSize: 30)))
            ],
          ),
        ));
  }
}

class TimeWidget extends StatefulWidget {
  const TimeWidget({Key? key, required this.initialLocalTime})
      : super(key: key);

  final String initialLocalTime;
  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  late DateTime _dateTime;
  late Timer _timer;

  String get _timeString =>
      DateFormat(DateFormat.HOUR_MINUTE).format(_dateTime);

  @override
  void initState() {
    super.initState();
    var localTime = widget.initialLocalTime;
    if (localTime.length == 15) {
      localTime = "${localTime.substring(0, 11)}0${localTime.substring(11)}";
    }
    _dateTime = DateTime.parse(localTime);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime.add(const Duration(seconds: 1));
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_timeString,
        style: GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 30)));
  }
}
