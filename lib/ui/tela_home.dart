// QUESTÃO 3) TelaHome, ListView, FloatingActionButton "+"

import 'package:flutter/material.dart';
import 'package:pdm_segunda_prova/ui/tela_cadastro.dart';
import 'package:pdm_segunda_prova/widgets/lista_paises.dart';
import 'package:pdm_segunda_prova/ui/tela_sobre.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  // Função para atualizar a lista
  void _atualizarLista() {
    setState(() {
      // Atualize a lista aqui se necessário
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Países"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaSobre(),
                ),
              );
            },
          ),
        ],
      ),
      body: HomeBody(atualizarLista: _atualizarLista),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaCadastro(),
            ),
          ).then((_) {
            // Atualize a lista após a volta da tela de cadastro
            _atualizarLista();
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  final VoidCallback atualizarLista;

  const HomeBody({Key? key, required this.atualizarLista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ListPaises(atualizarLista: atualizarLista),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
