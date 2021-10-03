import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc_eng_comp/view_model/test_view_model.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var viewModel = Modular.get<TestViewModel>();

  _TestPageState() {
    viewModel.task = viewModel.onFinish().listen((_) {
      Navigator.of(context).pushNamed(viewModel.finishRoute);
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: Text(
                viewModel.testMessage,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.deepOrange;
                      return Colors.deepOrangeAccent; // Use the component's default.
                    },
                  ),
                ),
                child: Text(
                  viewModel.abortButtonLabel,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  viewModel.abortClick();
                  Navigator.of(context).pushNamed(viewModel.abortButtonRoute);
                }),
          )
        ],
      ),
    );
  }
}
