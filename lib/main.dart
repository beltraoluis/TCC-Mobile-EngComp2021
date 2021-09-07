import 'package:flutter/material.dart';
import 'package:tcc_eng_comp/route.dart';

void main() {
  runApp(TccEngComp());
}

class TccEngComp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCC Engenharia de Computação 2020',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}


