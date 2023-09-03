import 'package:flutter/material.dart';
import 'package:trilhaapp/service/app_storage_service.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  AppStorageService storage = AppStorageService();

  String? nomeUsuario;
  double? altura;
  bool receberNotificacoes = false;
  bool temaEscuro = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    nomeUsuarioController.text = await storage.getConfiguracoesNomeUsuario();
    alturaController.text =
        (await (storage.getConfiguracoesAltura())).toString();
    receberNotificacoes = await storage.getConfiguracoesReceberNotificacao();
    temaEscuro = await storage.getConfiguracoesTemaEscuro();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Configurações"),
        ),
        body: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: nomeUsuarioController,
                  decoration: const InputDecoration(hintText: "Nome usuário"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "Altura"),
                ),
              ),
              SwitchListTile(
                title: const Text("Receber Notificações"),
                onChanged: (bool value) {
                  setState(() {
                    receberNotificacoes = value;
                  });
                },
                value: receberNotificacoes,
              ),
              SwitchListTile(
                title: const Text("Tema escuro"),
                onChanged: (bool value) {
                  setState(() {
                    temaEscuro = value;
                  });
                },
                value: temaEscuro,
              ),
              TextButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await storage.setConfiguracoesNomeUsuario(
                        nomeUsuarioController.text);
                    try {
                      await storage.setConfiguracoesAltura(
                          double.parse(alturaController.text));
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text("My app"),
                              content: const Text(
                                  "Favor inserir uma altura válida!"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"))
                              ],
                            );
                          });
                      return;
                    }

                    await storage.setConfiguracoesReceberNotificacao(
                        receberNotificacoes);
                    await storage.setConfiguracoesTemaEscuro(temaEscuro);
                    Navigator.pop(context);
                  },
                  child: const Text("Salvar"))
            ],
          ),
        ),
      ),
    );
  }
}
