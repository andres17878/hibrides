import 'package:flutter/material.dart';
import '../models/record.dart';
import '../models/shared.dart';

class NewRecord extends StatefulWidget {
  _NewRecord createState() => _NewRecord();
}

class _NewRecord extends State<NewRecord> {
  String titol = '';
  String descripcio = '';

  TextEditingController titolController = TextEditingController();
  TextEditingController descripcioController = TextEditingController();

  @override
  void dispose() {
    titolController.dispose();
    descripcioController.dispose();
    super.dispose();
  }

  void handleTitolChange() {
    setState(() {
      titol = titolController.text.trim();
    });
  }

  void handleDescripcioChange() {
    setState(() {
      descripcio = descripcioController.text.trim();
    });
  }

  void handleBack() async {
    if (titol.isEmpty) {
      if (descripcio.isEmpty) {
        Navigator.pop(context);
        return;
      } else {
        String titulo = descripcio.split('\n')[0];
        if (titulo.length > 20) {
          titulo = titulo.substring(0, 20);
        }
        setState(() {
          titol = titulo;
        });
      }
    }

    Record recordObject = Record(titol: titol, descripcio: descripcio);

    try {
      await Shared().addRecord(recordObject);
    } catch (e) {
      print(e);
    } finally {
      Navigator.pop(context, 'refresh');
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    titolController.addListener(handleTitolChange);
    descripcioController.addListener(handleDescripcioChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            handleBack(),
          },
        ),
        title: RecordTitolEntry(titolController),
      ),
      body: RecordEntry(descripcioController),
    );
  }
}

class RecordTitolEntry extends StatelessWidget {
  final _textFieldController;

  RecordTitolEntry(this._textFieldController);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textFieldController,
      decoration: InputDecoration(
        hintText: 'Titol',
      ),
    );
  }
}

class RecordEntry extends StatelessWidget {
  final _textFieldController;

  RecordEntry(this._textFieldController);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textFieldController,
      decoration: InputDecoration(
        hintText: 'Descripcio',
      ),
    );
  }
}
