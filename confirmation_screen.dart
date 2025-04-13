import 'dart:convert';
import 'package:flutter/material.dart';

class ConfirmationScreen extends StatefulWidget {
  var nome;
  var endereco;
  var complemento;
  var cep;

  ConfirmationScreen({this.nome, this.endereco, this.complemento, this.cep});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bem vindo, " + widget.nome,
          style: TextStyle(fontSize: 15),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Ação do botão de voltar
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color.fromARGB(255, 169, 222, 228),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
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
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.nome,
                          style:
                              TextStyle(color: Color.fromARGB(255, 39, 33, 77)),
                        ),
                        Text(
                          widget.cep,
                          style:
                              TextStyle(color: Color.fromARGB(255, 39, 33, 77)),
                        ),
                        Text(
                          widget.complemento,
                          style:
                              TextStyle(color: Color.fromARGB(255, 39, 33, 77)),
                        ),
                        Text(
                          widget.endereco,
                          style:
                              TextStyle(color: Color.fromARGB(255, 39, 33, 77)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Spacer(), // Ocupa o espaço restante
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.08),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 169, 222, 228))),
                            child: Text(
                              "Confirmar vazamento",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ));
        },
      ),
    );
  }
}
