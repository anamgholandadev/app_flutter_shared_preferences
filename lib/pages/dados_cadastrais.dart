import 'package:flutter/material.dart';
import 'package:trilhaapp/repository/linguagens_repository.dart';
import 'package:trilhaapp/repository/nivel_repository.dart';
import 'package:trilhaapp/service/app_storage_service.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

// ignore: must_be_immutable
class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController dataNascimentoController = TextEditingController();
  DateTime? dataNascimento;
  var niveis = [];
  var linguagens = [];
  double salarioEscolhido = 0;
  int tempoExperiencia = 0;
  bool salvando = false;
  var nivelSelecionado = "";
  List<String> linguagensSelecionadas = [];
  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();
  AppStorageService storage = AppStorageService();

  final String CHAVE_DADOS_CADASTRAIS_NOME = "CHAVE_DADOS_CADASTRAIS_NOME";
  final String CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO =
      "CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO";
  final String CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA =
      "CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA";
  final String CHAVE_DADOS_CADASTRAIS_LINGUAGENS =
      "CHAVE_DADOS_CADASTRAIS_LINGUAGENS";
  final String CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA =
      "CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA";
  final String CHAVE_DADOS_CADASTRAIS_SALARIO =
      "CHAVE_DADOS_CADASTRAIS_SALARIO";

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    nomeController.text = await storage.getDadosCadastraisNome();
    dataNascimentoController.text =
        await storage.getDadosCadastraisDataNascimento();
    if (dataNascimentoController.text.isNotEmpty) {
      dataNascimento = DateTime.parse(dataNascimentoController.text);
    }
    nivelSelecionado = await storage.getDadosCadastraisNivelExperiencia();
    linguagensSelecionadas = await storage.getDadosCadastraisLinguagens();
    tempoExperiencia = await storage.getDadosCadastraisTempoExperiencia();
    salarioEscolhido = await storage.getDadosCadastraisSalario();
    setState(() {});
  }

  List<DropdownMenuItem> returnItens(int qntMax) {
    var itens = <DropdownMenuItem>[];
    for (var i = 0; i < qntMax; i++) {
      itens.add(DropdownMenuItem(value: i, child: Text(i.toString())));
    }
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus dados"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const TextLabel(texto: "Nome"),
                  TextField(
                    controller: nomeController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextLabel(texto: "Data de Nascimento"),
                  TextField(
                    controller: dataNascimentoController,
                    readOnly: true,
                    onTap: () async {
                      var data = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000, 1, 1),
                          firstDate: DateTime(1900, 1, 1),
                          lastDate: DateTime(2023, 1, 1));
                      if (data != null) {
                        dataNascimentoController.text = data.toString();
                        dataNascimento = data;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextLabel(texto: "Nível de Experiência:"),
                  Column(
                    children: niveis
                        .map((nivel) => RadioListTile(
                            title: Text(nivel.toString()),
                            selected: nivelSelecionado == nivel,
                            value: nivel.toString(),
                            groupValue: nivelSelecionado,
                            onChanged: (value) {
                              setState(() {
                                nivelSelecionado = value.toString();
                              });
                            }))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextLabel(texto: "Linguagens Favoritas:"),
                  Column(
                      children: linguagens
                          .map((linguagem) => CheckboxListTile(
                              title: Text(linguagem),
                              value: linguagensSelecionadas.contains(linguagem),
                              onChanged: (bool? value) {
                                if (value!) {
                                  setState(() {
                                    linguagensSelecionadas.add(linguagem);
                                  });
                                } else {
                                  setState(() {
                                    linguagensSelecionadas.remove(linguagem);
                                  });
                                }
                              }))
                          .toList()),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextLabel(texto: "Tempo de Experiência:"),
                  DropdownButton(
                      value: tempoExperiencia,
                      isExpanded: true,
                      items: returnItens(50),
                      onChanged: (value) {
                        setState(() {
                          tempoExperiencia = int.parse(value.toString());
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextLabel(
                      texto:
                          "Pretensão Salarial: R\$ ${salarioEscolhido.round()}"),
                  Slider(
                      min: 0,
                      max: 10000,
                      value: salarioEscolhido,
                      onChanged: (double value) {
                        setState(() {
                          salarioEscolhido = value;
                        });
                      }),
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          salvando = false;
                        });
                        if (nomeController.text.trim().length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("O campo nome não pode ser vazio")));
                          return;
                        }
                        if (dataNascimento == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Data de Nascimento inválida")));
                          return;
                        }
                        if (nivelSelecionado.trim() == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("O nível deve ser selecionado")));
                          return;
                        }
                        if (linguagensSelecionadas.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Deve ser selecionada ao menos uma linguagem")));
                          return;
                        }
                        if (linguagensSelecionadas.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Deve ser selecionada ao menos uma linguagem")));
                          return;
                        }
                        if (tempoExperiencia == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Deve ter ao menos um ano de experiência")));
                          return;
                        }
                        if (salarioEscolhido == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "A pretensão salarial deve ser maior que zero")));
                          return;
                        }
                        await storage
                            .setDadosCadastraisNome(nomeController.text);
                        await storage
                            .setDadosCadastraisDataNascimento(dataNascimento!);
                        await storage.setDadosCadastraisNivelExperiencia(
                            nivelSelecionado);
                        await storage.setDadosCadastraisLinguagens(
                            linguagensSelecionadas);
                        await storage.setDadosCadastraisTempoExperiencia(
                            tempoExperiencia);
                        await storage
                            .setDadosCadastraisSalario(salarioEscolhido);
                        setState(() {
                          salvando = true;
                        });
                        Future.delayed(const Duration(seconds: 2), () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Dados salvos com sucesso")));
                          setState(() {
                            salvando = false;
                          });
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("Salvar"))
                ],
              ),
      ),
    );
  }
}
