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

  void handleTitolChange(String value) {
    setState(() {
      titol = value;
    });
  }

  void handleDescripcioChange(String value) {
    setState(() {
      descripcio = value;
    });
  }

  void handleBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    titolController.addListener(() {
      handleTitolChange(titolController.text);
    });
    descripcioController.addListener(() {
      handleDescripcioChange(descripcioController.text);
    });
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
