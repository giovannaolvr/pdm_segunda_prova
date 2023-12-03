// QUESTAO 9) SOBRE 

import 'package:flutter/material.dart';

class TelaSobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Sobre"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza os elementos verticalmente
          children: [
            Text(
              'Devs',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Giovanna Oliveira\nJoão Victor Gomes',
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center, // Centraliza o texto horizontalmente
            ),
            SizedBox(height: 64),
            Text(
              'Orientador',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Taniro Rodrigues',
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center, // Centraliza o texto horizontalmente
            ),
            SizedBox(height: 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centraliza os elementos horizontalmente
              children: [
                Icon(
                  Icons.favorite, // Substitua pelo ícone desejado
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  'Feito com amor\n(e um pouco de estresse)',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
