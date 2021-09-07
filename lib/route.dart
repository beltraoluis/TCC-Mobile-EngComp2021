

import 'package:flutter/material.dart';
import 'package:tcc_eng_comp/view/menu_screen.dart';
import 'package:tcc_eng_comp/view/my_home_page.dart';
import 'package:tcc_eng_comp/view/send_data_screen.dart';
import 'package:tcc_eng_comp/view/test_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
          return MaterialPageRoute(builder: (_) => MenuPage());
      case '/test':
        return MaterialPageRoute(builder: (_) => TestPage());
      case '/send_data':
        return MaterialPageRoute(builder: (_) => SendDataPage());
      case '/example':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => MyHomePage(
                  title: 'Flutter Demo Home Page $args'
              )
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Erro'),
        ),
        body: Center(
          child: Text(
              "Algo estranho aconteceu!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      );
    });
  }

}

