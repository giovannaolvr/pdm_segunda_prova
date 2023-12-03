// QUESTÃO 5) TelaCadastro, Cadastrar País, validação, SnackBar

import 'package:flutter/material.dart';
import 'package:pdm_segunda_prova/domain/pais.dart';
import 'package:pdm_segunda_prova/helpers/pais_helper.dart';
import 'package:pdm_segunda_prova/ui/tela_home.dart';
import 'package:pdm_segunda_prova/widgets/custom_form_fiel.dart';

class TelaCadastro extends StatelessWidget {
  const TelaCadastro({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cadastrar Novo País"),
      ),
      body: GestureDetector(
        onTap: () {
          // Fecha o teclado ao tocar fora dos campos de texto
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: FormPaisBody(),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}

class FormPaisBody extends StatefulWidget {
  const FormPaisBody({
    Key? key,
  }) : super(key: key);

  @override
  _FormPaisBodyState createState() => _FormPaisBodyState();
}

class _FormPaisBodyState extends State<FormPaisBody> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final capitalController = TextEditingController();
  final continenteController = TextEditingController();
  final liguaOficialController = TextEditingController();
  final populacaoController = TextEditingController();
  final moedaController = TextEditingController();

  final paisHelper = PaisesHelper();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            CustomFormField(
              controller: nomeController,
              labelText: "Nome",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione um nome';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: capitalController,
              labelText: "Capital",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione a capital do país';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: continenteController,
              labelText: "Continente",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione um continente';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: liguaOficialController,
              labelText: "Língua Oficial",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione a língua oficial do país';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: populacaoController,
              keyboard_type: TextInputType.number,
              labelText: "População",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione a população';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: moedaController,
              labelText: "Moeda",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione a moeda';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Pais p = Pais(
                      nomeController.text,
                      capitalController.text,
                      continenteController.text,
                      liguaOficialController.text,
                      double.tryParse(populacaoController.text) ?? 0.0,
                      moedaController.text,
                    );
                    paisHelper.savePais(p);

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
                        content: Text('País cadastrado com sucesso!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  "Cadastrar",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
