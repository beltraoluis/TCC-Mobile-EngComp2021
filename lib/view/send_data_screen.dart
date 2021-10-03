import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc_eng_comp/view_model/send_data_view_model.dart';

class SendDataPage extends StatefulWidget {
  const SendDataPage({Key? key}) : super(key: key);

  @override
  _SendDataPageState createState() => _SendDataPageState();
}

var viewModel = Modular.get<SendDataViewModel>();

class _SendDataPageState extends State<SendDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(viewModel.appBarTitle),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  viewModel.sendDataMessage,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.green;
                            return Colors.lightGreen; // Use the component's default.
                          },
                        ),
                      ),
                      child: Text(
                        viewModel.yesButtonLabel,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        viewModel.yesClick();
                        Navigator.of(context).pushNamed('/');
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 16),
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
                          viewModel.noButtonLabel,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          viewModel.noClick();
                          Navigator.of(context).pushNamed('/');
                        }
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
