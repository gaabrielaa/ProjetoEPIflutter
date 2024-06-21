import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetoepi/Provider/admin/colaborador.dart';
import 'package:projetoepi/Style/colors.dart';
import 'package:projetoepi/Utils/mensage.dart';
import 'package:projetoepi/Widget/botao.dart';
import 'package:projetoepi/Widget/field.dart';
import 'package:provider/provider.dart';

class Admfunc extends StatefulWidget {
  const Admfunc({super.key});

  @override
  State<Admfunc> createState() => _admfuncState();
}

class _admfuncState extends State<Admfunc> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _ctps = TextEditingController();
  final TextEditingController _telefone = TextEditingController();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _dataAdmissao = TextEditingController();

  @override
  void dispose() {
    _nome.clear();
    _ctps.clear();
    _telefone.clear();
    _cpf.clear();
    _email.clear();
    _dataAdmissao.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ColaboradorProvider>(builder: (context, colabprovider, _) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrativo', style: TextStyle(color: white)),
        centerTitle: true,
        backgroundColor: const Color(0xff112EC8),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff112EC8), Colors.white],             
          ),
        ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                children: [
                  customTextField(
                    title: 'Nome do Funcionário',
                    controller: _nome,
                    hint: 'Digite o nome do funcionário',
                    tipo: TextInputType.text
                  ),
                  customTextField(
                    title: 'CTPS do Funcionário',
                    controller: _ctps,
                    hint: 'Digite o CTPS o do funcionário',
                    tipo: TextInputType.text
                  ),
                  customTextField(
                    title: 'Telefone do Funcionário',
                    controller: _telefone,
                    hint: 'Digite o telefone do funcionário',
                    tipo: TextInputType.phone,
                    formatacao: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ]
                  ),
                  customTextField(
                    title: 'CPF do Funcionário',
                    controller: _cpf,
                    hint: 'Digite o CPF do funcionário',
                    tipo: TextInputType.text,
                    formatacao: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ]
                  ),
                  customTextField(
                    title: 'E-mail do Funcionário',
                    controller: _email,
                    hint: 'Digite o e-mail do funcionário',
                    tipo: TextInputType.text
                  ),
                  customTextField(
                    title: 'Data de admissão do Funcionário',
                    controller: _dataAdmissao,
                    hint: 'Digite a data de admissão do funcionário',
                    tipo: TextInputType.datetime,
                    formatacao: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter(),
                    ]
                  ),
                  customButton(
                    tap: () {
                      if (_formKey.currentState!.validate()) {
                        colabprovider.cadastrar(
                          context, 
                          _nome.text, 
                          _ctps.text, 
                          _telefone.text, 
                          _cpf.text, 
                          _email.text, 
                          _dataAdmissao.text,
                        );
                      } else {
                        showMessage(
                          message: "Todos os campos devem ser preenchidos",
                          context: context);
                      }
                    },
                    text: "Concluir",
                    context: context,
                    status: colabprovider.carregando)
                    ],
                  ),
                ),
            ),
          ),
          ),
        ),
      );
    });
  }
}