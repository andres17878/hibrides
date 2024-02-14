import 'package:flutter/material.dart';
import './new_record.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          appBar: AppBar(
              backgroundColor: Colors.blue,
              title:
                  const Text('Records', style: TextStyle(color: Colors.white))),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewRecord()),
              );
            },
          )),
    );
  }
}
