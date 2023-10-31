import 'package:flutter/material.dart';

class ComptadorEnter extends StatelessWidget {
  final int comptador;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ComptadorEnter({super.key, 
    required this.comptador,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$comptador',
        ),
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: onIncrement,
            ),
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: onDecrement,
            ),
          ],
        ),
      ],
    );
  }
}
