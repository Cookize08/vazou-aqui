import 'package:flutter/material.dart';
import 'package:vazouaqui/pages/authentication.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.07,
                          bottom: MediaQuery.of(context).size.width * 0.07),
                      child: Image.asset(
                        "assets/images/cano_quebrado.jpeg",
                        width: 340,
                        height: 386,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: EdgeInsets.all(35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Venha reportar o vazamento de água",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 39, 33, 77),
                              ),
                            ),
                            SizedBox(height: 10), // Espaçamento entre textos
                            Text(
                              "Aqui você poderá reportar o local a onde está havendo o vazamento da água, para a CAERD consertar o cano",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 93, 87, 126)),
                            ),
                            Spacer(), // Ocupa o espaço restante
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.width * 0.08),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        Color.fromARGB(255, 169, 222, 228))),
                                child: Text(
                                  "Vamos continuar",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Authentication()),
                                  );
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
          );
        },
      ),
    );
  }
}
