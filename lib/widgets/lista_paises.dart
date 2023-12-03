//QUESTAO 8) Listagem do ListView, GestureDetector 

import 'package:flutter/material.dart';
import 'package:pdm_segunda_prova/domain/pais.dart';
import 'package:pdm_segunda_prova/helpers/pais_helper.dart';
import 'package:pdm_segunda_prova/ui/tela_alterar.dart';
import 'package:pdm_segunda_prova/ui/tela_detalhes.dart';

class ListPaises extends StatelessWidget {
  const ListPaises({Key? key, required VoidCallback atualizarLista});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ListBody(),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}

class ListBody extends StatefulWidget {
  const ListBody({super.key});

  @override
  State<ListBody> createState() => _ListPaisesState();
}

class _ListPaisesState extends State<ListBody> {
  final paisesHelper = PaisesHelper();
  late Future<List> pais;

  @override
  void initState() {
    super.initState();
    pais = paisesHelper.getAll();
  }

  // Função de atualização da lista
  void _atualizarLista() {
    setState(() {
      pais = paisesHelper.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pais,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return ListItem(pais: snapshot.data![i], atualizarLista: _atualizarLista);
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final Pais pais;
  final VoidCallback atualizarLista;

  const ListItem({Key? key, required this.pais, required this.atualizarLista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaDetalhes(paisId: pais.id),
          ),
        );
      },
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaAltera(paisId: pais.id, atualizarLista: atualizarLista),
          ),
        ).then((_) {
          // Atualiza a lista após a volta da tela de alteração
          atualizarLista();
        });
      },
      child: ListTile(
        title: Text(pais.nome),
      ),
    );
  }
}
