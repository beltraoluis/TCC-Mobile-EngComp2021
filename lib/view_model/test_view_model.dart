import 'dart:async';

import 'package:tcc_eng_comp/model/test_business_model.dart';

class TestViewModel {
  var testMessage = 'Testando...';
  var abortButtonLabel = 'Parar Teste';
  var finishRoute = '/send_data';
  var abortButtonRoute = '/';

  var _model = TestBusinessModel();
  var _messageSize = 0;
  var _messageDelta = 0;
  var _messageQty = 0;

  StreamSubscription<bool>? task;

  Future<void> onStart() async {
    _messageSize = await _model.getMessageSize();
    _messageDelta = await _model.getMessageDelta();
    _messageQty = await _model.getMessageQty();
  }

  Stream<bool> onFinish() {
    //TODO remove mock
    return Future.delayed(Duration(seconds: 5), () => true).asStream();
  }

  abortClick() {
    task?.cancel();
    //TODO Request model to close connection and stop the test
  }
}