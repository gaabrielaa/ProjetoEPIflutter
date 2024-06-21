import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetoepi/Pages/confirm_password.dart';
import 'package:projetoepi/Provider/cadastro/varifica_usuario.dart';
import 'package:projetoepi/Style/colors.dart';
import 'package:projetoepi/Utils/mensage.dart';
import 'package:projetoepi/Widget/botao.dart';
import 'package:projetoepi/Widget/field.dart';
import 'package:provider/provider.dart';

class SingnupScreen extends StatelessWidget {
  const SingnupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Cadastre-se", style: TextStyle(color: white)),
          centerTitle: true,
          backgroundColor: const Color(0xff112EC8)),
      body: const SignupForm(),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  @override
  void dispose() {
    _cpfController.clear();
    _emailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsuarioCadastrado>(builder: (context, usuario, _) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff112EC8), Colors.white],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customTextField(
                  title: 'Email',
                  controller: _emailController,
                  hint: 'Digite seu e-mail',
                  tipo: TextInputType.emailAddress
                ),
                customTextField(
                  title: 'CPF',
                  controller: _cpfController,
                  hint: 'Digite seu CPF',
                  formatacao: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ]
                ),
                const SizedBox(height: 30),
                SizedBox(
                    width: 150,
                    child: customButton(
                      tap: () async {
                        await usuario.checarUsuario(
                              _cpfController.text, _emailController.text);
                          if (usuario.valido) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConfirmPassword(
                                          email: _emailController.text,
                                          cpf: _cpfController.text,
                                        )));
                          } else {
                            showMessage(
                                message: usuario.msgError, context: context);
                          }
                        },
                      text: "Avançar",
                      context: context,
                      status: usuario.carregando
                  )
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
