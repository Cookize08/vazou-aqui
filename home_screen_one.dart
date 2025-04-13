import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vazouaqui/pages/confirmation_screen.dart';

class HomeScreenOne extends StatefulWidget {
  var nome;

  HomeScreenOne({super.key, this.nome});

  @override
  State<HomeScreenOne> createState() => _HomeScreenOneState();
}

class _HomeScreenOneState extends State<HomeScreenOne> {
  var formKey = GlobalKey<FormState>();
  final cepController = TextEditingController();
  final enderecoController = TextEditingController();
  final complementoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cepController.addListener(() {
      String cep = cepController.text;
      String cepSemTraco = cep.replaceAll("-", "");
      if (cepSemTraco.length == 8) {
        // chamar API
        callApiCep(cepSemTraco).then((value) {
          enderecoController.text =
              value["logradouro"] + " - " + value["bairro"];
        });
      }
    });
  }

  Future callApiCep(String cep) async {
    final response =
        await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));

    var body = jsonDecode(response.body);

    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bem vindo, " + widget.nome,
          style: const TextStyle(fontSize: 15),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Ação do botão de voltar
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 169, 222, 228),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                    child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "CEP",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 39, 33, 77)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: cepController,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "CEP inválido";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: "Ex: 00000-000",
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 247, 245, 245),
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(178, 194, 189, 189))),
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              maxLength: 9,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Endereço do local",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 39, 33, 77)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: enderecoController,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Endereço inválido";
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: "Ex: Rua Piau, 5877",
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 247, 245, 245),
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(178, 194, 189, 189))),
                              obscureText: false,
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Complemento",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 39, 33, 77)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: complementoController,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Complemento inválido";
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: "Ex: Em frente a casa azul",
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 247, 245, 245),
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(178, 194, 189, 189))),
                              obscureText: false,
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Image.asset(
                                "assets/images/maps.jpeg",
                                height: 200,
                              ),
                            ),
                            const Spacer(), // Ocupa o espaço restante
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.width * 0.08),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all<
                                            Color>(
                                        const Color.fromARGB(255, 169, 222, 228))),
                                child: const Text(
                                  "Confirmar local do vazamento",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConfirmationScreen(
                                                  nome: widget.nome,
                                                  cep: cepController.text,
                                                  endereco:
                                                      enderecoController.text,
                                                  complemento:
                                                      complementoController
                                                          .text,
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
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
