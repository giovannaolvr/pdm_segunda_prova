// QUESTAO 7) TelaDetalhes, recebe ID, Texts com registros

import 'package:flutter/material.dart';
import 'package:pdm_segunda_prova/domain/pais.dart';
import 'package:pdm_segunda_prova/helpers/pais_helper.dart';

class TelaDetalhes extends StatelessWidget {
  final int paisId;

  const TelaDetalhes({Key? key, required this.paisId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Detalhes do País"),
      ),
      body: FutureBuilder(
        future: PaisesHelper().getPais(paisId),
        builder: (context, AsyncSnapshot<Pais?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Erro ao carregar os detalhes do país.'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Nenhum detalhe do país encontrado.'));
          } else {
            Pais pais = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Nome: ${pais.nome}'),
                ),
                ListTile(
                  title: Text('Capital: ${pais.capital}'),
                ),
                ListTile(
                  title: Text('Continente: ${pais.continente}'),
                ),
                ListTile(
                  title: Text('Língua Oficial: ${pais.linguaOficial}'),
                ),
                ListTile(
                  title: Text('População: ${pais.populacao}'),
                ),
                ListTile(
                  title: Text('Moeda: ${pais.moeda}'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
