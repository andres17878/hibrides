import 'package:flutter/material.dart';
import 'package:llista_compra/models/llista_articles.dart';
import 'package:llista_compra/ui_widgets/comptador_enter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LlistaArticles(),
      child: const Llista(),
    ),
  );
}

class Llista extends StatelessWidget {
  const Llista({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Llista de la compra';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const Formulario(),
      ),
    );
  }
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Usuari"),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Si us plau introdueix text';
              }

              if (value != "obret") {
                return 'Usuari incorrecte';
              }
              return null;
            },
          ),
          const Text("Contrasenya"),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Si us plau introdueix text';
              }

              if (value != "sesam") {
                return 'Contrasenya incorrecta';
              }
              return null;
            },
            obscureText: true,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListaCompra()),
                    );
                  }
                },
                child: const Text('Submit'),
              )),
        ],
      ),
    );
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
            return FutureBuilder<List<Article>>(
              future: value.fetchArticles(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.shopping_cart),
                        title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(snapshot.data![index].nom.toString()),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: ComptadorEnter(
                                        article: (snapshot.data![index])),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      value.deleteArticle(
                                          snapshot.data![index].id!);
                                    },
                                  ),
                                ],
                              )
                            ]),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            );
          },
        )),
      ],
    );
  }
}
