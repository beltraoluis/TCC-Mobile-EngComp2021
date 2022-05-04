import 'package:tcc_eng_comp/model/menu_business_model.dart';
import 'package:tcc_eng_comp/data/fog_item.dart';
import 'package:tcc_eng_comp/data/fog_protocol.dart';

class MenuViewModel {
  var appBarTitle = 'Menu';
  var mainServer = '';
  var mainServerLabel = 'Servidor principal';
  var messageBroker = '';
  var messageBrokerLabel = 'Servidor de mensagens';
  var username = '';
  var usernameLabel = 'Usuário';
  var password = '';
  var passwordLabel = 'Senha';
  var messageSize = '';
  var messageSizeLabel = 'Tamanho da mensagem';
  var messageDelta = '';
  var messageDeltaLabel = 'Intervalo entre mensagens (ms)';
  var messageQty = '';
  var messageQtyLabel = 'Quantidade de mensagens';
  var energyText = 'Teste de energia';
  var isEnergyTest = false;
  var testButton = 'EXECUTAR TESTE';
  var testButtonRoute = '/test';

  FogProtocol? protocol = FogProtocol.AMQP;
  var radioButtonLabels = [
    FogItem('AMQP',  FogProtocol.AMQP),
    FogItem('MQTT', FogProtocol.MQTT),
    FogItem('STOMP', FogProtocol.STOMP)
  ];
  var _model = MenuBusinessModel();

  Future<void> initialize() async {
    mainServer = await _model.getBackendUrl();
    messageBroker = await _model.getBrokerHost();
    username = await _model.getUser();
    password =  await _model.getPassword();
    messageSize = await _model.getMessageSize();
    messageDelta = await _model.getMessageDelta();
    messageQty = await _model.getMessageQty();
    isEnergyTest = await _model.getEnergyTest();
    protocol = await _model.getProtocol();
  }

  radioClick(FogProtocol? protocol) {
    this.protocol = protocol;
  }

  buttonClick() {
    _model.setBackendUrl(mainServer);
    _model.setBrokerUrl(messageBroker);
    _model.setUser(username);
    _model.setPassword(password);
    _model.setMessageSize(messageSize);
    _model.setMessageDelta(messageDelta);
    _model.setMessageQty(messageQty);
    _model.setEnergyTest(isEnergyTest);
    _model.setProtocol(protocol);
  }
}