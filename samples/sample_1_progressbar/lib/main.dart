import 'package:flutter/material.dart';

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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const ProgressBarPage(),
    );
  }
}

class ProgressBarPage extends StatefulWidget {
  const ProgressBarPage({Key? key}) : super(key: key);

  @override
  _ProgressBarPageState createState() => _ProgressBarPageState();
}

class _ProgressBarPageState extends State<ProgressBarPage> {
  double _progress = 0.1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _changeProgress() {
    if (_progress >= 0.9) {
      _progress = 0.1;
    } else {
      _progress += 0.1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                value: _progress,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: LinearProgressIndicator(
                value: _progress,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(_changeProgress);
                },
                child: const Text('Increase'))
          ],
        ),
      ),
    );
  }
}
