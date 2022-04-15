import 'dart:async';

import 'package:tcc_eng_comp/data/fog_protocol.dart';
import 'package:tcc_eng_comp/model/test_business_model.dart';
import 'package:tcc_eng_comp/repository/fog/amqp_repository.dart';
import 'package:tcc_eng_comp/repository/fog_repository.dart';

class TestViewModel {
  var testMessage = 'Testando...';
  var abortButtonLabel = 'Parar Teste';
  var finishRoute = '/send_data';
  var abortButtonRoute = '/';

  var _model = TestBusinessModel();
  var _messageSize = 0;
  var _messageDelta = 0;
  var _messageQty = 0;
  var _protocol = FogProtocol.AMQP;

  StreamSubscription<bool>? task;

  Future<void> onStart() async {
    _messageSize = await _model.getMessageSize();
    _messageDelta = await _model.getMessageDelta();
    _messageQty = await _model.getMessageQty();
    _protocol = await _model.getProtocol();
  }

  Stream<bool> onFinish() {
    Future.delayed(Duration(seconds: 5), () {
      onStart();
      FogRepository client;
      switch(_protocol) {
        case FogProtocol.STOMP:
        case FogProtocol.MQTT:
        case FogProtocol.AMQP: {
          client = AMQPRepository();
        }
      }
      client.connect(() {
        client.send('teste');
      });
    });
    return Future.delayed(Duration(seconds: 5), () => true).asStream();
  }

  abortClick() {
    task?.cancel();
    //TODO Request model to close connection and stop the test
  }
}