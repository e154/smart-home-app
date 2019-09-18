import 'package:smart_home_app/common/common.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:web_socket_channel/io.dart';

class ServerStream {
  IOWebSocketChannel channel;
  bool cancelOnError;

  connect() {
    Settings settings = MainState.get().settings;

    final uri = Uri.parse(settings.serverAddress);
    final scheme = (uri.scheme == 'http') ? 'ws' : 'wss';

    try {
      channel = new IOWebSocketChannel.connect(
          scheme + '://' + uri.host + ':' + uri.port.toString() + '/ws',
          headers: {
            'X-API-Key': settings.accessToken,
            'X-Client-Type': 'mobile',
          });
      channel.stream.listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
    } catch (e) {}
  }

  close() {
    channel.sink.close();
  }

  onData(dynamic data) {
    print(data);
  }

  onError(dynamic data) {
    print(data);
  }

  onDone() {}

  sendMessage(dynamic data) {
    channel.sink.add(data);
  }
}
