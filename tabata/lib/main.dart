import 'package:flutter/material.dart';

import 'dart:async';

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
  int contadorCiclos = 1;
  Timer? _timer;

  void _startTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          // Cuando el temporizador llega a 0, reinicia el contador y el temporizador
          _counter = 5;
          contadorCiclos++;

          if (contadorCiclos > 4) {
            contadorCiclos = 1;
          }
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
                  child: Text('Cycle #$contadorCiclos/4'),
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
                    onPressed: _startTimer,
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
