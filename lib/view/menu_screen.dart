import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc_eng_comp/util/fog_protocol.dart';
import 'package:tcc_eng_comp/view_model/menu_view_model.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

var viewModel = Modular.get<MenuViewModel>();

class _MenuPageState extends State<MenuPage> {

  @override
  void initState() {
    viewModel.initialize().then((value) {
      state
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(viewModel.appBarTitle),
          automaticallyImplyLeading: false),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                  initialValue: viewModel.mainServer,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: viewModel.mainServerLabel,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    labelStyle: TextStyle(fontSize: 16, color: Colors.yellow),
                  ),
                  onChanged: (text) {
                    viewModel.mainServer = text;
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                  initialValue: viewModel.messageBroker,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: viewModel.messageBrokerLabel,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    labelStyle: TextStyle(fontSize: 16, color: Colors.yellow),
                  ),
                  onChanged: (text) {
                    viewModel.messageBroker = text;
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                  initialValue: viewModel.username,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: viewModel.usernameLabel,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    labelStyle: TextStyle(fontSize: 16, color: Colors.yellow),
                  ),
                  onChanged: (text) {
                    viewModel.username = text;
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                  initialValue: viewModel.password,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: viewModel.passwordLabel,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    labelStyle: TextStyle(fontSize: 16, color: Colors.yellow),
                  ),
                  onChanged: (text) {
                    viewModel.password = text;
                  }),
            ),
            ListTile(
              title: Text(viewModel.radioButtonLabels[0].name,
                  style: TextStyle(color: Colors.white)),
              leading: Radio<FogProtocol>(
                fillColor: MaterialStateProperty.all<Color>(Colors.white),
                value: viewModel.radioButtonLabels[0].value,
                groupValue: viewModel.protocol,
                onChanged: (FogProtocol? value) {
                  setState(() {
                    viewModel.radioClick(value);
                  });
                },
              ),
            ),
            ListTile(
              title: Text(viewModel.radioButtonLabels[1].name,
                  style: TextStyle(color: Colors.white)),
              leading: Radio<FogProtocol>(
                fillColor: MaterialStateProperty.all<Color>(Colors.white),
                value: viewModel.radioButtonLabels[1].value,
                groupValue: viewModel.protocol,
                onChanged: (FogProtocol? value) {
                  setState(() {
                    viewModel.radioClick(value);
                  });
                },
              ),
            ),
            ListTile(
              title: Text(viewModel.radioButtonLabels[2].name,
                  style: TextStyle(color: Colors.white)),
              leading: Radio<FogProtocol>(
                fillColor: MaterialStateProperty.all<Color>(Colors.white),
                value: viewModel.radioButtonLabels[2].value,
                groupValue: viewModel.protocol,
                onChanged: (FogProtocol? value) {
                  setState(() {
                    viewModel.radioClick(value);
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                  initialValue: viewModel.messageSize,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: viewModel.messageSizeLabel,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    labelStyle: TextStyle(fontSize: 16, color: Colors.yellow),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    viewModel.messageSize = text;
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                  initialValue: viewModel.messageQty,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: viewModel.messageQtyLabel,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    labelStyle: TextStyle(fontSize: 16, color: Colors.yellow),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    viewModel.messageQty = text;
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                  initialValue: viewModel.messageDelta,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: viewModel.messageDeltaLabel,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    labelStyle: TextStyle(fontSize: 16, color: Colors.yellow),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    viewModel.messageDelta = text;
                  }),
            ),
            Expanded(
                child: SizedBox(
              height: 1,
            )),
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                child: Text(
                  viewModel.testButton,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  viewModel.buttonClick();
                  Navigator.of(context).pushNamed(viewModel.testButtonRoute);
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
