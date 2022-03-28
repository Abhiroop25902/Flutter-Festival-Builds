import 'package:flutter/material.dart';
import 'package:weather_app/networking.dart';
import 'package:weather_app/weather_info.dart';
import 'package:weather_app/weather_page.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 1.5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  onSubmitted: (_) => sendData(),
                  controller: _controller,
                  decoration: const InputDecoration(hintText: 'Enter Place'),
                  textAlign: TextAlign.center,
                )),
            ElevatedButton(
                onPressed: () {
                  sendData();
                },
                child: const Text('Search')),
          ],
        ),
      ),
    );
  }

  void sendData() {
    var text = _controller.text;
    _controller.clear();

    if (text.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FutureBuilder<WeatherInfo>(
                  future: getWeatherInfo(location: text),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return WeatherPage(weatherInfo: snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Scaffold(
                        appBar: AppBar(),
                        body: Center(child: Text(snapshot.error.toString())),
                      );
                    }
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  })));
    }
  }
}
