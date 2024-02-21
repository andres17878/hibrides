import 'package:flutter/material.dart';
import 'package:records/models/record.dart';
import './new_record.dart';
import '../models/shared.dart';

List<Record> records = [];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Shared().getRecords().then((value) {
      setState(() {
        records = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          appBar: AppBar(
              backgroundColor: Colors.blue,
              title:
                  const Text('Records', style: TextStyle(color: Colors.white))),
          body: FutureBuilder(
            future: Shared().getRecords(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(records[index].titol),
                      subtitle: Text(records[index].descripcio),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await Shared.removeRecord(records[index]);
                          setState(() {
                            records.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewRecord()),
              ).then((value) {
                if (value != null) {
                  setState(() {});
                }
              });
            },
          )),
    );
  }
}
