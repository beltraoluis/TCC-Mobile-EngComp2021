import 'dart:async';
import 'dart:developer';

import 'package:tcc_eng_comp/model/test_business_model.dart';
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
  var _isEnergyTest = false;
  FogRepository? client;

  StreamSubscription<bool>? task;

  Future<void> initialize() async {
    _messageSize = await _model.getMessageSize();
    _messageDelta = await _model.getMessageDelta();
    _messageQty = await _model.getMessageQty();
    _isEnergyTest = await _model.getEnergyTest();
  }

  Stream<bool> execute() {
    Future.delayed(Duration(seconds: 5), () {
      initialize();
      _model.testConnection().then((value) async {
          log('Conexão testada. Iniciando os envios');
          if(_isEnergyTest){
            await _model.executeEnergyTest(_messageSize, _messageQty, _messageDelta);
          }
          else {
            await _model.executeTest(_messageSize, _messageQty, _messageDelta);
          }
        });
    });
    return Future.delayed(Duration(seconds: 5), () => true).asStream();
  }

  abortClick() {
    task?.cancel();
    client?.disconnect(() => log('disconnected'));
  }
}