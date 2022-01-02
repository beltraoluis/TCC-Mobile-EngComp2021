
abstract class FogRepository {
  void connect(String user, String password, Function() onConnect );
  void disconnect(Function() onDisconnect);
  void send(String message);
}