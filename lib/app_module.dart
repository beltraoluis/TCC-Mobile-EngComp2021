import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc_eng_comp/view_model/menu_view_model.dart';
import 'package:tcc_eng_comp/view_model/send_data_view_model.dart';
import 'package:tcc_eng_comp/view_model/test_view_model.dart';

import 'main.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => MenuViewModel()),
    Bind((i) =>SendDataViewModel()),
    Bind((i) => TestViewModel())
  ];

}