import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetoepi/Provider/admin/entrega.dart';
import 'package:projetoepi/Style/colors.dart';
import 'package:projetoepi/Utils/mensage.dart';
import 'package:projetoepi/Widget/botao.dart';
import 'package:projetoepi/Widget/field.dart';
import 'package:provider/provider.dart';

class EntregaScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _dataValidade = TextEditingController();
  final _dataEntrega = TextEditingController();

  EntregaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entrega', style: TextStyle(color: white)),
      centerTitle: true,
      backgroundColor: const Color(0xff112EC8),
      ),
      body: Consumer<EntregaProvider>(
        builder: (context, dataProvider, child) {
          return Container(
            decoration: const BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff112EC8), Colors.white],             
          ),
        ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        customTextField(
                            title: 'Data de Validade',
                            controller: _dataValidade,
                            hint: 'Digite a Data',
                            tipo: TextInputType.datetime,
                            formatacao: [
                              FilteringTextInputFormatter.digitsOnly,
                              DataInputFormatter(),
                            ]),
                        customTextField(
                            title: 'Data de Entrega',
                            controller: _dataEntrega,
                            hint: 'Digite a Data de Entrega',
                            tipo: TextInputType.datetime,
                            formatacao: [
                              FilteringTextInputFormatter.digitsOnly,
                              DataInputFormatter(),
                            ]),
                      ],
                    ),
                  ),
                  customButton(
                      text: "Cadastrar",
                      tap: () async {
                        if (_formKey.currentState!.validate()) {
                          dataProvider.setDataValidade(_dataValidade.text);
                          dataProvider.setDataEntrega(_dataEntrega.text);
                          await dataProvider.criarEntrega();

                          if (dataProvider.sucesso == true) {
                            showMessage(
                              message: "Entrega criada com sucesso",
                              // ignore: use_build_context_synchronously
                              context: context);
                          } else {
                            showMessage(
                              message: "Erro ao cadastrar entrega",
                              // ignore: use_build_context_synchronously
                              context: context);
                          } 
                        }
                      },
                      context: context)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}