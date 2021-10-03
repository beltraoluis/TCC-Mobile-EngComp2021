import 'dart:async';

class TestViewModel {
  var testMessage = 'Testando...';
  var abortButtonLabel = 'Parar Teste';
  var finishRoute = '/send_data';
  var abortButtonRoute = '/';

  StreamSubscription<bool>? task;

  onStart() {
    //TODO Request model to open connection and start the test
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