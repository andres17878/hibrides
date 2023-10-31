import 'package:flutter/material.dart';

class LlistaArticles extends ChangeNotifier {
  final List<Article> _articles = [];

  void afegeix(Article article) {
    _articles.add(article);
    notifyListeners();
  }

  void treu(Article article) {
    _articles.remove(article);
    notifyListeners();
  }

  void incrementCounter(int index) {
    if (index >= 0 && index < _articles.length) {
      _articles[index] = Article(
        id: _articles[index].id,
        nom: _articles[index].nom,
        quantity: _articles[index].quantity + 1,
      );
      notifyListeners();
    }
  }

  void decrementCounter(int index) {
    if (index >= 0 &&
        index < _articles.length &&
        _articles[index].quantity > 0) {
      _articles[index] = Article(
        id: _articles[index].id,
        nom: _articles[index].nom,
        quantity: _articles[index].quantity - 1,
      );
      notifyListeners();
    }
  }

  Article itemAt(int index) {
    return _articles[index];
  }

  Article getByNom(String nom) {
    return _articles.firstWhere((article) => article.nom == nom);
  }

  int count() {
    return _articles.length;
  }
}

class Article {
  final int? id;
  final String nom;
  final int quantity;

  Article({
    required this.id,
    required this.nom,
    required this.quantity,
  });
}
