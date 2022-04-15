import "package:dart_amqp/dart_amqp.dart";
import 'package:tcc_eng_comp/repository/fog_repository.dart';
import 'package:tcc_eng_comp/repository/preference_repository.dart';

class AMQPRepository extends FogRepository {
  late Client _client;
  late Channel _channel;
  Function(String) _onMessage = (message) => {};

  void connect(Function() onConnect ) async {
    ConnectionSettings settings = ConnectionSettings(
        host: await PreferenceRepository.getBrokerHost(),
        port: 5672,
        virtualHost: await PreferenceRepository.getUser(),
        authProvider: AmqPlainAuthenticator(
            await PreferenceRepository.getUser(),
            await PreferenceRepository.getPassword())
    );
    _client = Client(settings: settings);
    _channel = await _client.channel();
    Queue queue = await _channel.queue("tcc-amqp");
    Consumer consumer = await queue.consume();
    consumer.listen((AmqpMessage message) {
      _onMessage.call(message.payloadAsString);
      // Get the payload as a string
      print(" [x] Received string: ${message.payloadAsString}");

      // Or unserialize to json
      print(" [x] Received json: ${message.payloadAsJson}");

      // Or just get the raw data as a Uint8List
      print(" [x] Received raw: ${message.payload}");

      // The message object contains helper methods for
      // replying, ack-ing and rejecting
      message.reply("world");
    });
  }

  void send(String message) async {
    Exchange exchange = await _channel.exchange("logs", ExchangeType.FANOUT);
    exchange.publish(message, null);
  }

  void onMessageReceived(Function(String) onMessage){
    _onMessage = onMessage;
  }

  void disconnect(Function() onDisconnect) {
    _client.close().then((value) => onDisconnect.call());
  }
}