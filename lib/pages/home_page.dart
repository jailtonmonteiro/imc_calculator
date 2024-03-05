import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weighController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String infoText = "Informe seus dados";

  void resetFields() {
    weighController.text = "";
    heightController.text = "";
    setState(() {
      infoText = "Informe seus dados";
      formKey = GlobalKey<FormState>();
    });
  }

  void calculateIMC() {
    setState(() {
      double weight = double.parse(weighController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if (imc < 18.6) {
        infoText = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora de IMC',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: resetFields,
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outlined,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: weighController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu Peso";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura (Cm)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua Altura";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      calculateIMC();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Calcular',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Text(
                infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
