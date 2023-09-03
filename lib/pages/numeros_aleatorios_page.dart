import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trilhaapp/service/app_storage_service.dart';

class NumeroAleatoriosPage extends StatefulWidget {
  const NumeroAleatoriosPage({super.key});

  @override
  State<NumeroAleatoriosPage> createState() => _NumeroAleatoriosPageState();
}

class _NumeroAleatoriosPageState extends State<NumeroAleatoriosPage> {
  int numeroGerado = 0;
  int quantidadeCliques = 0;

  AppStorageService storage = AppStorageService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    numeroGerado = await storage.getNumeroAleatorio();
    quantidadeCliques = await storage.getQuantidadeCliques();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Gerador de Números Aleatórios"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              numeroGerado == null
                  ? "Nenhum número gerado"
                  : numeroGerado.toString(),
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              quantidadeCliques == null
                  ? "Nenhum clique efetuado"
                  : quantidadeCliques.toString(),
              style: const TextStyle(fontSize: 24),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(1000);
              quantidadeCliques = (quantidadeCliques ?? 0) + 1;
            });
            await storage.setNumeroAleatorio(numeroGerado);
            await storage.setQuantidadeCliques(quantidadeCliques);
          },
        ));
  }
}
