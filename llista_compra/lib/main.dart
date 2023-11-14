import 'package:flutter/material.dart';
import 'package:llista_compra/models/llista_articles.dart';
import 'package:llista_compra/ui_widgets/comptador_enter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LlistaArticles(),
      child: const Formulario(),
    ),
  );
}

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  FormularioState createState() {
    return FormularioState();
  }
}

class FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          )
        ]));
  }
}

class ListaCompra extends StatelessWidget {
  const ListaCompra({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Llista de la compra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Llista compra'),
      ),
      body: const ElMeuBody(),
    );
  }
}

class ElMeuBody extends StatelessWidget {
  const ElMeuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<LlistaArticles>(builder: (context, model, _) {
            return TextField(
              controller: TextEditingController(),
              decoration: const InputDecoration(
                labelText: 'Ingresi un article',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  model.afegeix(Article(id: null, nom: text, quantity: 1));
                }
              },
            );
          }),
        ),
        Expanded(child: Consumer<LlistaArticles>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.count(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(value.itemAt(index).nom),
                        Row(
                          children: [
                            ComptadorEnter(
                              comptador: value.itemAt(index).quantity,
                              onIncrement: () {
                                value.incrementCounter(index);
                              },
                              onDecrement: () {
                                value.decrementCounter(index);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                value.treu(value.itemAt(index));
                              },
                            ),
                          ],
                        )
                      ]),
                );
              },
            );
          },
        )),
      ],
    );
  }
}
