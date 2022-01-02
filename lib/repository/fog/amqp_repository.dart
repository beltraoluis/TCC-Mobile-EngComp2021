import "package:dart_amqp/dart_amqp.dart";

class AMQPRepository {
  late Client client;
  late Channel channel;

  void connect() async {
    ConnectionSettings settings = ConnectionSettings(
        host: "192.168.1.150",
        port: 5672,
        authProvider: PlainAuthenticator("admin", "admin123456")
    );
    client = Client(settings: settings);
    channel = await client.channel();
    Queue queue = await channel.queue("hello");
    Consumer consumer = await queue.consume();
    consumer.listen((AmqpMessage message) {
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
    Exchange exchange = await channel.exchange("logs", ExchangeType.FANOUT);
    exchange.publish(message, null);
  }

  void disconnect() {
    client.close();
  }
}