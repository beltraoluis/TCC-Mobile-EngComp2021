// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc_eng_comp/route.dart';

import 'app_module.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: TccEngComp()));
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


