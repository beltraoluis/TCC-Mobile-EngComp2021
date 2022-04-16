import 'package:http/http.dart' as http;
import 'dart:convert';

class CoreRepository {

  var client = http.Client();

  Future<bool> testMainServerConnection(mainServer) async {
    var url = Uri.parse(mainServer + '/');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> testSendDataToMainServer(mainServer, messageBody) async {
    var url = Uri.parse(mainServer + '/save/test');
    final messageHeader = {"Content-type": "application/json"};
    String jsonMessageBody = jsonEncode(messageBody);
    final response = await client.put(url, headers: messageHeader, body: jsonMessageBody);
    if (response.statusCode == 202) {
      return true;
    } else {
      return false;
    }
  }
}


