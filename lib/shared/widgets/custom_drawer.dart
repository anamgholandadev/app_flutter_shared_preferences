import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/configuracoes.dart';
import 'package:trilhaapp/pages/dados_cadastrais.dart';
import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/numeros_aleatorios_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    title: const Text("Camera"),
                                    leading: const Icon(Icons.camera),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    title: const Text("Galeria"),
                                    leading: const Icon(Icons.album),
                                  )
                                ],
                              );
                            });
                      },
                      child: UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.network(
                                  "https://hermes.digitalinnovation.one/assets/diome/logo.png")),
                          accountName: const Text("Ana Holanda"),
                          accountEmail: const Text("email@email.com")),
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Dados Cadastrais"),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DadosCadastrais()));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(Icons.lock),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Termos de uso e privacidade"),
                          ],
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext bc) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 12),
                                child: const Column(
                                  children: [
                                    Text(
                                      "Termos de uso e privacidade",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard orem Ipsum has been the industry's standard dumorem Ipsum has been the industry's standard dum dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(Icons.engineering),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Configurações"),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext bc) =>
                                    const ConfiguracoesPage()));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(Icons.calculate),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Gerador de Números"),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext bc) =>
                                    const NumeroAleatoriosPage()));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(Icons.exit_to_app),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Sair"),
                          ],
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext bc) {
                              return AlertDialog(
                                title: const Text("Meu App"),
                                content: const Wrap(
                                  children: [
                                    Text("Você sairá do aplicativo!"),
                                    Text("Realmente deseja fazer isso?"),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Não")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                      },
                                      child: const Text("Sim")),
                                ],
                              );
                            });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
