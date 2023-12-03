//QUESTAO 6) TelaAltera, Alterar país, validação, ScankBar

import 'package:flutter/material.dart';
import 'package:pdm_segunda_prova/domain/pais.dart';
import 'package:pdm_segunda_prova/helpers/pais_helper.dart';
import 'package:pdm_segunda_prova/ui/tela_home.dart';

class TelaAltera extends StatefulWidget {
  final int paisId;
  final VoidCallback atualizarLista; // Adiciona o parâmetro para a função de atualização

  const TelaAltera({Key? key, required this.paisId, required this.atualizarLista}) : super(key: key);

  @override
  _TelaAlteraState createState() => _TelaAlteraState();
}

class _TelaAlteraState extends State<TelaAltera> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _continenteController = TextEditingController();
  final TextEditingController _linguaController = TextEditingController();
  final TextEditingController _populacaoController = TextEditingController();
  final TextEditingController _moedaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarPais();
  }

  void _carregarPais() async {
    Pais? pais = await PaisesHelper().getPais(widget.paisId);

    if (pais != null) {
      _nomeController.text = pais.nome;
      _capitalController.text = pais.capital;
      _continenteController.text = pais.continente;
      _linguaController.text = pais.linguaOficial;
      _populacaoController.text = pais.populacao.toString();
      _moedaController.text = pais.moeda;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Editar País'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _capitalController,
              decoration: InputDecoration(labelText: 'Capital'),
            ),
            TextField(
              controller: _continenteController,
              decoration: InputDecoration(labelText: 'Continente'),
            ),
            TextField(
              controller: _linguaController,
              decoration: InputDecoration(labelText: 'Língua Oficial'),
            ),
            TextField(
              controller: _populacaoController,
              decoration: InputDecoration(labelText: 'População'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _moedaController,
              decoration: InputDecoration(labelText: 'Moeda'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _atualizarPais();

                // Navega de volta à tela principal
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaHome(),
                  ),
                );

                // Mostra o SnackBar com a mensagem
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('País alterado com sucesso!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }

  void _atualizarPais() async {
    Pais paisAtualizado = Pais.withId(
      widget.paisId,
      _nomeController.text,
      _capitalController.text,
      _continenteController.text,
      _linguaController.text,
      double.parse(_populacaoController.text),
      _moedaController.text,
    );

    int result = await PaisesHelper().updatePais(paisAtualizado);

    if (result > 0) {
      Navigator.pop(context);

      // Chama a função de atualização da listad
      widget.atualizarLista();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Falha ao atualizar o país.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
