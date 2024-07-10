import 'package:flutter/material.dart';
import 'package:form_v/tela/form_v.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Validation"),
      ),
      body: FormV(),
    );
  }
}
