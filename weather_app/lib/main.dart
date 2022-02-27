import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  Widget _weatherRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('30',
          style:
              GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 80))),
      Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Text('°C',
            style:
                GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 50))),
      ),
      Image.network(
        'http://cdn.weatherapi.com/weather/64x64/night/122.png',
        scale: 0.6,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mumbai',
            style: GoogleFonts.openSans(),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TimeWidget(),
              _weatherRow(),
              Text('Mumbai, Maharashtra',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(fontSize: 30)))
            ],
          ),
        ));
  }
}

class TimeWidget extends StatefulWidget {
  const TimeWidget({Key? key}) : super(key: key);

  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  String _timeString = "";

  String get _currTime {
    return DateFormat(DateFormat.HOUR_MINUTE_SECOND).format(DateTime.now());
  }

  @override
  void initState() {
    super.initState();
    _timeString = _currTime;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeString = _currTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_timeString,
        style: GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 30)));
  }
}
