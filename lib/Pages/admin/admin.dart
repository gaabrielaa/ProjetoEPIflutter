import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetoepi/Style/colors.dart';
import 'package:projetoepi/Widget/botao.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _adminState();
}

class _adminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrativo', style: TextStyle(color: white)),
        centerTitle: true,
        backgroundColor: const Color(0xff112EC8),
      ),
      body: Center(
        child: Container(
            decoration: const BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff112EC8), Colors.white],             
          ),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Bem-Vindo', style: TextStyle(fontSize: 27),),
              const SizedBox(height: 40),
              customButton(
                text: "Cadastrar EPI",
                tap: () {
                  Navigator.pushNamed(context, '/admepi');
                },
                context: context),
                customButton(
                  text: "Cadastrar Funcionário", tap: () {
                    Navigator.pushNamed(context, '/admfunc');
                  }, context: context),
                customButton(
                  text: "Cadastrar Entrega", tap: () {
                    Navigator.pushNamed(context, '/admentrega');
                  }, context: context)
            ],
          ),
        ),
      ),
    );
  }
}