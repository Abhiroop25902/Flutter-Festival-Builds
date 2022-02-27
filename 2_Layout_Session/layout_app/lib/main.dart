import 'package:flutter/material.dart';
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  final _padding = 20.0;

  Widget _titleRow() {
    return Padding(
      padding: EdgeInsets.all(_padding),
      child: Row(
        children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Oeschinen Lake Campground',
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30)),
              ),
              Text('Kandersteg, Switzerland',
                  style: GoogleFonts.openSans(
                      textStyle:
                          const TextStyle(color: Colors.grey, fontSize: 15)))
            ]),
          ),
          const IconCountWidget()
        ],
      ),
    );
  }

  Widget _actionRow() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          ActionWidget(iconData: Icons.call, label: 'CALL'),
          ActionWidget(iconData: Icons.near_me, label: 'ROUTE'),
          ActionWidget(iconData: Icons.share, label: 'SHARE'),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Image.asset(
          'assets/images/lake.jpg',
          height: 300,
          fit: BoxFit.cover,
        ),
        _titleRow(),
        _actionRow(),
        Padding(
          padding: EdgeInsets.all(_padding),
          child: Text(
            'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. '
            'Situated 1,578 meters above sea level, it is one of the larger Alpine '
            'Lakes. A gondola ride from Kandersteg, followed by a half-hour walk '
            'through pastures and pine forest, leads you to the lake, '
            'which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
            softWrap: true,
            style: GoogleFonts.openSans(),
          ),
        )
      ],
    ));
  }
}

class IconCountWidget extends StatefulWidget {
  const IconCountWidget({Key? key}) : super(key: key);

  @override
  _IconCountWidgetState createState() => _IconCountWidgetState();
}

class _IconCountWidgetState extends State<IconCountWidget> {
  bool _selected = true;
  int _count = 100;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                if (_selected) {
                  _count--;
                } else {
                  _count++;
                }

                _selected = !_selected;
              });
            },
            icon: Icon(
              _selected ? Icons.star : Icons.star_border_outlined,
              color: Colors.red,
            )),
        Container(
            alignment: Alignment.center,
            width: 30,
            child: Text(_count.toString()))
      ],
    );
  }
}

class ActionWidget extends StatefulWidget {
  const ActionWidget({Key? key, required this.iconData, required this.label})
      : super(key: key);
  final IconData iconData;
  final String label;

  @override
  _ActionWidgetState createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget> {
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                if (_color == Colors.blue) {
                  _color = Colors.red;
                } else {
                  _color = Colors.blue;
                }
              });
            },
            icon: Icon(widget.iconData, color: _color)),
        Text(widget.label,
            style: GoogleFonts.openSans(textStyle: TextStyle(color: _color)))
      ],
    );
  }
}
