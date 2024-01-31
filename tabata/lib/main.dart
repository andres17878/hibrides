import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _counter = 5;
  int _ciclo = 1;
  Timer? _timer;
  String _titulo = 'Cicle 0/4';

  final player = AudioPlayer();

  String fort = 'fort.mp3';
  String fluix = 'fluix.mp3';

  void start() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }

    player.stop();
    _ciclo = 1;
    _counter = 5;
    _titulo = 'Cicle ${_ciclo}/4';
    timer();
  }

  void comprova() {
    setState(() {
      _ciclo++;
      _titulo = 'Cicle ${_ciclo}/4';
      if (_ciclo < 4) {
        timer();
      }
    });
  }

  Future<void> timer2() async {
    _counter = 4;
    await player.play(UrlSource(fluix));
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (_counter < 1) {
          t.cancel();
          player.stop();
          comprova();
        } else {
          _counter--;
        }
      });
    });
  }

  Future<void> timer() async {
    _counter = 5;
    await player.play(UrlSource(fort));
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (_counter < 1) {
          t.cancel();
          player.stop();
          timer2();
        } else {
          _counter--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Text('Header'),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text('Main Content: $_counter'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      start();
                    },
                    child: Text('Start / Reset'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
