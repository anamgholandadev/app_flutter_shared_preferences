import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController senhaController = TextEditingController(text: "");
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              Row(children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 8,
                  child: Image.network(
                    "https://hermes.digitalinnovation.one/assets/diome/logo.png",
                  ),
                ),
                Expanded(child: Container()),
              ]),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Já tem cadastro?",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Faça seu login e make de change_",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.center,
                height: 30,
                child: TextField(
                  controller: emailController,
                  onChanged: (valueEmail) {
                    debugPrint(valueEmail);
                  },
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(top: 0),
                      hintText: "Email",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.purple,
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.center,
                height: 30,
                child: TextField(
                  controller: senhaController,
                  obscureText: isObscureText,
                  onChanged: (valueSenha) {
                    debugPrint(valueSenha);
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 0),
                      hintText: "Senha",
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.purple,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                        },
                        child: Icon(
                          isObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.purple,
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      // ignore: unrelated_type_equality_checks
                      if (emailController.text.trim() == "email@email.com" &&
                          // ignore: unrelated_type_equality_checks
                          senhaController.text.trim() == "123") {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Erro ao Efeturar Login")));
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.cyan)),
                    child: const Text(
                      "ENTRAR",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                height: 30,
                alignment: Alignment.center,
                child: const Text("Esqueci minha senha",
                    style: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.w400)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                height: 30,
                alignment: Alignment.center,
                child: const Text("Criar Conta",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
