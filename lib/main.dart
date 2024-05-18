import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Duration _duration = Duration(seconds: 0);
  Timer? _timer;

  void _startTimer(int seconds) {
    setState(() {
      _duration = Duration(seconds: seconds);
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds > 0) {
          _duration -= Duration(seconds: 1);
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String formattedTime =
        "${twoDigits(_duration.inHours)}:${twoDigits(_duration.inMinutes)}:${twoDigits(_duration.inSeconds)}";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Timer'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(formattedTime, style: TextStyle(fontSize: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () =>
                        _startTimer(30), // Set default duration to 30 seconds
                    child: Text("Start 30s"),
                  ),
                  SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: _timer != null ? _timer!.cancel : null,
                    child: Text("Stop"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
