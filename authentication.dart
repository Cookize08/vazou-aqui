import 'package:flutter/material.dart';
import 'package:vazouaqui/pages/home_screen_one.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final nomeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 169, 222, 228),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.07,
                            bottom: MediaQuery.of(context).size.width * 0.07),
                        child: Image.asset(
                          "assets/images/authentication_man.png",
                          width: 340,
                          height: 386,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.all(35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Seu nome",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 39, 33, 77)),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return "Nome inválido";
                                  }

                                  return null;
                                },
                                autovalidateMode: AutovalidateMode.disabled,
                                controller: nomeController,
                                decoration: const InputDecoration(
                                    hintText: "Ex: Jorge",
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 247, 245, 245),
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(
                                            178, 194, 189, 189))),
                                obscureText: false,
                                keyboardType: TextInputType.name,
                              ),
                              const Spacer(), // Ocupa o espaço restante
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.08),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 169, 222, 228))),
                                  child: const Text(
                                    "Comece",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    String nome = nomeController.text;
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreenOne(
                                                    nome: nome,
                                                  )));
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
