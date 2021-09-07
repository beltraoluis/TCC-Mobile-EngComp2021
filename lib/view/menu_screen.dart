import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

enum FogProtocol { STOMP, MQTT, AMQP }

class _MenuPageState extends State<MenuPage> {
  FogProtocol? _protocol = FogProtocol.STOMP;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Menu'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Servidor principal',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  labelStyle: TextStyle(fontSize: 16, color: Colors.yellow),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Servidor de mensagens',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  labelStyle: TextStyle(fontSize: 16, color: Colors.yellow),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  labelStyle: TextStyle(fontSize: 16, color: Colors.yellow),
                ),
              ),
            ),
            ListTile(
              title: const Text('STOMP', style: TextStyle(color: Colors.white),),
              leading: Radio<FogProtocol>(
                fillColor: MaterialStateProperty.all<Color>(Colors.white),
                value: FogProtocol.STOMP,
                groupValue: _protocol,
                onChanged: (FogProtocol? value) {
                  setState(() {
                    _protocol = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('MQTT', style: TextStyle(color: Colors.white),),
              leading: Radio<FogProtocol>(
                fillColor: MaterialStateProperty.all<Color>(Colors.white),
                value: FogProtocol.MQTT,
                groupValue: _protocol,
                onChanged: (FogProtocol? value) {
                  setState(() {
                    _protocol = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('AMQP', style: TextStyle(color: Colors.white),),
              leading: Radio<FogProtocol>(
                fillColor: MaterialStateProperty.all<Color>(Colors.white),
                value: FogProtocol.AMQP,
                groupValue: _protocol,
                onChanged: (FogProtocol? value) {
                  setState(() {
                    _protocol = value;
                  });
                },
              ),
            ),
            Expanded(child: SizedBox(height: 1,)),
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('/test',);
                  },
                  child: Text(
                    'EXECUTAR TESTE',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
