import 'package:flutter/material.dart';
import 'package:tcc_eng_comp/util/fog_item.dart';
import 'package:tcc_eng_comp/util/fog_protocol.dart';

class MenuViewModel {
  var appBarTitle = 'Menu';
  var _mainServer = '';
  var mainServerLabel = 'Servidor principal';
  var _messageBroker = '';
  var messageBrokerLabel = 'Servidor de mensagens';
  var _password = '';
  var passwordLabel = 'Senha';
  var testButton = 'EXECUTAR TESTE';
  var testButtonRoute = '/test';

  FogProtocol? protocol = FogProtocol.STOMP;
  var radioButtonLabels = [
    FogItem('STOMP',  FogProtocol.STOMP),
    FogItem('MQTT', FogProtocol.MQTT),
    FogItem('AMQP', FogProtocol.AMQP)
  ];


  MenuViewModel(){
    //TODO request previous saved data to model
  }

  radioClick(FogProtocol? protocol) {
    this.protocol = protocol;
  }

  buttonClick() {
    //TODO contact model to save data
  }

  set password(value) {
    _password = value;
  }

  set messageBroker(value) {
    _messageBroker = value;
  }

  set mainServer(value) {
    _mainServer = value;
  }
}