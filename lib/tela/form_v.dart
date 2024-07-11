import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:form_v/tela/check_box.dart';
import 'package:radio_group_v2/radio_group_v2.dart';

class FormV extends StatefulWidget {
  const FormV({super.key});

  @override
  State<StatefulWidget> createState() => FormVState();
}

class FormVState extends State<FormV> {
  String? pais;
  RadioGroupController genero = RadioGroupController();
  bool termos = false;
  DateTime maioridade = DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    const List<String> paises = [
      "Brasil",
      "Colombia",
      "Peru",
      "Angola",
      "Palestina"
    ];

    return Form(
        key: formKey,
        child: Container(
          alignment: Alignment.center,
          color: const Color.fromARGB(255, 230, 237, 238),
          child: Column(
            //nota: é possível substituir column por wrap
            //caso eu não queira deixar esse spam de padding
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
              RadioGroup(
                indexOfDefault: 2,
                controller: genero,
                values: const [
                  "Feminino",
                  "Masculino",
                  "Prefiro não responder"
                ],
                orientation: RadioGroupOrientation.horizontal,
                decoration: const RadioGroupDecoration(
                  spacing: 10.0,
                  labelStyle: TextStyle(
                    color: Colors.blueAccent,
                  ),
                  activeColor: Colors.amber,
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              TextFormField(
                decoration: const InputDecoration(hintText: "Email"),
                validator: (email) {
                  if (email == null ||
                      !EmailValidator.validate(email) ||
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
                    return "Isso é um NUMERO?!";
                  }
                  return null;
                },
              ),
              const Padding(padding: EdgeInsets.all(10)),
              InputDatePickerFormField(
                fieldLabelText: "Data de nascimento",
                fieldHintText: "dd/mm/yyyy",
                firstDate: DateTime(1900, 1, 1),
                lastDate: maioridade,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              CheckboxFormField(
                title: const Text("Li e concordo com os termos de uso"),
                onSaved: (value) => {
                  setState(() {
                    termos = value ?? false;
                  })
                },
                validator: (termos) {
                  if (termos == false) {
                    return "É preciso concordar para validar seu cadastro!";
                  }
                  return null;
                },
              ),
              const Padding(padding: EdgeInsets.all(10)),
              const Padding(padding: EdgeInsets.all(10)),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      },
                      child: const Text("Enviar"))
                ],
              ),
            ],
          ),
        ));
  }
}
