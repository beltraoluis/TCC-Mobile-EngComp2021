import 'package:tcc_eng_comp/data/fog_protocol.dart';
import 'package:tcc_eng_comp/repository/fog/mqtt_repository.dart';
import 'package:tcc_eng_comp/repository/fog/stomp_repository.dart';
import 'package:tcc_eng_comp/repository/fog_repository.dart';
import 'package:tcc_eng_comp/repository/preference_repository.dart';
import 'package:tcc_eng_comp/repository/fog/amqp_repository.dart';
import 'dart:math';
import 'dart:convert';
import 'dart:io' show Platform;

class TestBusinessModel {
  FogRepository? client;
  var protocol;

  Future<int> getMessageSize() async {
  return PreferenceRepository.getMessageSize();
  }

  Future<int> getMessageDelta() async {
    return PreferenceRepository.getMessageDelta();

  }

  Future<int> getMessageQty() async {
    return PreferenceRepository.getMessageQty();
  }

  Future<String> getAccessKey() async {
    return PreferenceRepository.getPassword();
  }

  Future<String> getPlatform() async {
    return PreferenceRepository.getPassword();
  }

  Future<FogProtocol> _getProtocol() async {
    var protocolName = await PreferenceRepository.getProtocol();
    switch (protocolName) {
      case PreferenceRepository.mqtt: return FogProtocol.MQTT;
      case PreferenceRepository.stomp: return FogProtocol.STOMP;
      default: return FogProtocol.AMQP;
    }
  }


  Future<FogRepository> fogRepository() async {
    FogProtocol _protocol = await _getProtocol();
    var result;
    switch(_protocol) {
      case FogProtocol.MQTT: {
        this.protocol = 'MQTT';
        result = MqttRepository();
        break;
      }
      case FogProtocol.STOMP: {
        this.protocol = 'STOMP';
        result = StompRepository();
        break;
      }
      case FogProtocol.AMQP: {
      this.protocol = 'AMQP';
        result = AMQPRepository();
      }
    }
    return Future.delayed(Duration(seconds: 1), () => result);
  }

  Future<bool> testConnection() async {
      if (client == null){
        fogRepository().then((client) async {
          this.client = client;
          client.connect((message) {
            print(message);
            if (message == 'x') {
              client.disconnect(() => print('disconnected'));
            }
          });
          await Future.delayed(Duration(seconds: 1), () => true);
          try {
            client.send('teste');
            await Future.delayed(Duration(milliseconds: 100), () => true);
            client.send('x');
          } finally {
            print('Tentaiva de envio de mensagens para teste concluído');
          }
          return true;
        });
      }
    return Future.delayed(Duration(seconds: 1), () => true);
  }

  Future<void> executeTest(int messageSize, int messageQty, int messageDelta) async {
    var randomDelay = new Random();
    var randomValue;
    var platform;
    if (Platform.isAndroid) {
      platform = 'Android';
    } else if (Platform.isIOS) {
      platform = 'IOS';
    }
    String messageCreated;
    String baseMessageCalcString;
    String baseMessage;
    var baseMessageCalcValue;
    var messageObject;

    fogRepository().then((client) async {
      this.client = client;
      messageObject = {
        'accessKey': 'IzJUQ0MwSm9zZTJMdWlzMg==',
        'platform': platform,
        'protocol': this.protocol,
        'messageSize': messageSize,
        'sendTime': 0,
        'returnTime': 0,
        'intervalTime': 0,
        'messageDelta': messageDelta,
        'messagesSent': 0,
        'messagesReceived': 0,
        'x': ''
      };

      client.connect((message) {
        print(message);
        if (message == 'x') {
          client.disconnect(() => print('disconnected'));
        }
      });
      await Future.delayed(Duration(milliseconds: 1000));
      var msgIndex = 1;
      for (var i = 0 ; i < 10; i++) {
        for (var j = 0 ; j < messageQty; j++) {
          messageObject['sendTime'] = DateTime.now().millisecondsSinceEpoch;
          messageObject['messagesSent'] = msgIndex;
          msgIndex += 1;
          messageObject['x'] = '';
          baseMessageCalcString = jsonEncode(messageObject);

          if ( messageSize - baseMessageCalcString.length > 0 ) {
            baseMessage = '';
            baseMessageCalcValue = messageSize - baseMessageCalcString.length ;
            for (var k = 0; k < baseMessageCalcValue; k++) {
              baseMessage += '0';
            }
            messageObject['x'] = baseMessage;
          }
          messageCreated = jsonEncode(messageObject);
          await Future.delayed(Duration(milliseconds: messageDelta), () => client.send(messageCreated));
        }
        randomValue = randomDelay.nextInt(1000) + 1;
        messageObject['intervalTime'] = randomValue;
        await Future.delayed(Duration(milliseconds: randomValue));
      }
      await Future.delayed(Duration(seconds: 1), () => client.send('x'));
    });
  }
}