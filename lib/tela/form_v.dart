import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class FormV extends StatefulWidget {
  const FormV({super.key});

  @override
  State<StatefulWidget> createState() => FormVState();
}

class FormVState extends State<FormV> {
  String? pais;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    const List<String> paises = [
      "Brasil",
      "Colombia",
      "Peru",
      "Angola",
      "Palestina"
    ];

    return Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          color: const Color.fromARGB(255, 230, 237, 238),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(30)),
              const Text(
                "Cadastro com Validações",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              TextFormField(
                validator: (String? nome) {
                  if (nome == null || nome.isEmpty) {
                    return 'Insira seu nome!';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: "Nome completo"),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              TextFormField(
                decoration: const InputDecoration(hintText: "Email"),
                validator: (email) {
                  if (email == null ||
                      !EmailValidator.validate(email!) ||
                      !email.contains("@")) {
                    return "Insira um email válido!";
                  }
                  return null;
                },
              ),
              const Padding(padding: EdgeInsets.all(10)),
              DropdownButtonFormField<String>(
                value: pais,
                validator: (pais) {
                  if (pais == null || pais.isEmpty) {
                    return "Selecione seu país atual!";
                  }
                  return null;
                },
                hint: const Text("Selecione seu país"),
                onChanged: (String? pais2) {
                  setState(
                    () {
                      pais = pais2;
                    },
                  );
                },
                items: paises.map<DropdownMenuItem<String>>((String pais) {
                  return DropdownMenuItem<String>(
                    value: pais,
                    child: Text(pais),
                  );
                }).toList(),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              TextFormField(
                decoration:
                    const InputDecoration(hintText: "Telefone / Celular"),
                validator: (numero) {
                  if (double.tryParse(numero!) == null) {
                    return "Insira um email válido!";
                  }
                  return null;
                },
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: const Text("Enviar"))
                ],
              )
            ],
          ),
        ));
  }
}
