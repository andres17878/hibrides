// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TextField y ListView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class Qu extends StatefulWidget {
  const Qu({super.key});

  @override
  State<Qu> createState() => _QuState();
}

class _QuState extends State<Qu> {
  int comptador = 1;

  void _incrementa() {
    setState(() {
      comptador++;
    });
  }

  void _decrementa() {
    setState(() {
      if (comptador > 0) {
        comptador--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$comptador'),
        Column(
          children: <Widget>[
            IconButton(onPressed: _incrementa, icon: const Icon(Icons.add)),
            IconButton(onPressed: _decrementa, icon: const Icon(Icons.remove)),
          ],
        ),
        IconButton(onPressed: _decrementa, icon: const Icon(Icons.delete)),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _items = [];

  void _addItemToList(String newItem) {
    setState(() {
      _items.add(newItem);
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextField y ListView'),
      ),
      body: ElMeuBody(
        textEditingController: _textEditingController,
        addItemToList: _addItemToList,
        items: _items,
      ),
    );
  }
}

class ElMeuBody extends StatelessWidget {
  final TextEditingController textEditingController;
  final List<String> items;
  final Function(String) addItemToList;

  const ElMeuBody({
    super.key,
    required this.textEditingController,
    required this.items,
    required this.addItemToList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              labelText: 'Ingresi un article',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (text) {
              if (text.isNotEmpty) {
                addItemToList(text);
              }
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.double_arrow, color: Colors.white),
                  ),
                  title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(items[index]),
                        const Qu(),
                      ]));
            },
          ),
        ),
      ],
    );
  }
}
