import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class ListItem {
  final String text;
  final IconData icon;

  ListItem(this.text, this.icon);
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ListItem> _listItems = [ListItem('Text', Icons.star)];

  void _addItem(String text, IconData icon) {
    setState(() {
      _listItems.add(ListItem(text, icon));
    });
  }

  void _clearList() {
    setState(() {
      _listItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Llista')),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _listItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(_listItems[index].icon),
                  title: Text(_listItems[index].text),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _addItem('Hola', Icons.emoji_people),
                child: const Text('Hola'),
              ),
              ElevatedButton(
                onPressed: () => _addItem('Adéu', Icons.waving_hand),
                child: const Text('Adéu'),
              ),
              ElevatedButton(
                onPressed: _clearList,
                child: const Text('Esborra'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
