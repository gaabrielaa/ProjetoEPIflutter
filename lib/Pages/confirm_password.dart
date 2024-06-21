import 'package:flutter/material.dart';
import 'package:projetoepi/Provider/cadastro/valida_login.dart';
import 'package:projetoepi/Style/colors.dart';
import 'package:projetoepi/Utils/mensage.dart';
import 'package:projetoepi/Widget/botao.dart';
import 'package:projetoepi/Widget/field.dart';
import 'package:provider/provider.dart';

class ConfirmPassword extends StatelessWidget {
  final String email;
  final String cpf;

  const ConfirmPassword({super.key, required this.email, required this.cpf});

  @override
  Widget build(BuildContext context) {

    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordControler = TextEditingController();
    
    return Consumer<ValidarSenha>(builder: (context, ValidarSenha, _)
    {
      return Scaffold(
      appBar: AppBar(
        title: Text('Confirme sua Senha', style: TextStyle(color: white)),
        centerTitle: true,
        backgroundColor: const Color(0xff112EC8)
      ),
      body: Container(
      decoration:  const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff112EC8), Colors.white],             
          ),
      ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('E-mail: $email', style: const TextStyle(fontSize: 16),),
                Text('CPF: $cpf', style: const TextStyle(fontSize: 16),),
                const SizedBox(height: 40),

                customTextField(
                title: 'Senha',
                controller: passwordController,
                hint: 'Digite sua senha',
              ),
                customTextField(
                title: 'Comfirmar Senha',
                controller: confirmPasswordControler,
                hint: 'Digite sua senha',
              ),

                const SizedBox(height: 30),
                SizedBox(
                   width: 150,
                  child: customButton(
                    tap: () async {
                      if (passwordController.text != confirmPasswordControler.text) {
                        showMessage(
                          message: "As senhas devem ser iguais",
                          context: context);
                      } else {
                        var cpfint = cpf.replaceAll(RegExp(r'[^0-9]'), '');
                        ValidarSenha.createUser(email, passwordController.text, int.parse (cpfint));
                        showMessage(
                          message: ValidarSenha.msgErrorApi,
                          context: context);
                      }
                    },
                    text: "Concluir",
                    context: context,
                    status: ValidarSenha.carregando
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  });
  }
}