import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetoepi/Provider/admin/entrega.dart';
import 'package:projetoepi/Style/colors.dart';
import 'package:projetoepi/Widget/field.dart';
import 'package:provider/provider.dart';

class AdmEntrega extends StatefulWidget {
  const AdmEntrega({super.key});

  @override
  State<AdmEntrega> createState() => _AdmEntregaState();
}

class _AdmEntregaState extends State<AdmEntrega> {
  @override
  void initState() {
    Provider.of<EntregaProvider>(context, listen: false).fetchColaboradores();
    super.initState();
  }

//confirmar deleção
  Future _confirmDelete(BuildContext context, int idCol) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content:
              const Text('Tem certeza de que deseja excluir este colaborador?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Provider.of<EntregaProvider>(context, listen: false)
                    .deleteColaborador(idCol);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Cadastrar Entrega - Escolha o Colaborador', 
          style: TextStyle(color: white)),
          centerTitle: true,
          backgroundColor: const Color(0xff112EC8),
          ),
      body: Consumer<EntregaProvider>(
        builder: (context, dataProvider, _) {
          if (dataProvider.carregando == true) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: dataProvider.colaboradores.length,
              itemBuilder: (context, index) {
                
                final colaborador = dataProvider.colaboradores[index];

                return ListTile(
                  title: Text(dataProvider.colaboradores[index]['nomeCol']),
                  subtitle: Text(dataProvider.colaboradores[index]['email']),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await _confirmDelete(context, colaborador['idCol']);
                    },
                  ),

                  onTap: () {
                    dataProvider.setSelectedColaborador(
                        dataProvider.colaboradores[index]['idCol'],
                        dataProvider.colaboradores[index]['nomeCol']);
                    Navigator.pushNamed(context, '/episentrega');
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}