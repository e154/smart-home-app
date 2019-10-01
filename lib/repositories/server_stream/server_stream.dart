import 'dart:async';
import 'dart:convert';

import 'package:smart_home_app/common/common.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/repositories/server_stream/payload.dart';
import 'package:smart_home_app/repositories/server_stream/request.dart';
import 'package:smart_home_app/repositories/server_stream/response.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

import 'command_do_action.dart';

class ServerStream {
  IOWebSocketChannel _channel;
  bool _cancelOnError;
  Map _pool;
  StreamController streamController;

  ServerStream() {
    streamController = new StreamController();
    _pool = new Map();
  }

  void dispose(filename) {
    streamController.close();
  }

  connect() {
    _tryConnect();
  }

  _tryConnect() {
    Settings settings = MainState.get().settings;

    final uri = Uri.parse(settings.serverAddress);
    final scheme = (uri.scheme == 'http') ? 'ws' : 'wss';

    try {
      _channel = new IOWebSocketChannel.connect(
          scheme + '://' + uri.host + ':' + uri.port.toString() + '/ws',
          headers: {
            'X-API-Key': settings.accessToken,
            'X-Client-Type': 'mobile',
          });
      _channel.stream.listen(_onData,
          onError: _onError, onDone: _onDone, cancelOnError: _cancelOnError);
    } catch (e) {}
  }

  close() {
    _channel.sink.close();
  }

  //{"id":"4e71af1b-cf97-4f36-ba9d-6e15779591af","command":"","payload":{},"forward":"response","status":"success","type":""}
  _onData(dynamic data) {
    Map<String, dynamic> dataJson = jsonDecode(data);
    final response = Response.fromJson(dataJson);

//    print(data.toString());

    if (_pool != null) {
      bool exist = false;
      _pool.forEach((k, v) {
        if (k == response.id) {
          exist = true;
          v.complete(response.status);
        }
      });

      if (exist) {
        _pool.remove(response.id);
        return;
      }
    }

    streamController.sink.add(response);
  }

  _onError(dynamic data) {
    print('onError: ' + data.toString());
  }

  _onDone() async {
    await Future.delayed(Duration(seconds: 1));
    _tryConnect();
  }

  _sendMessage(dynamic data) {
    _channel.sink.add(data);
  }

  _command(String command, Payload payload, Completer c) {
    var uuid = new Uuid().v4();
    final request = new Request(id: uuid, command: command, payload: payload);
    _pool[uuid] = c;
    _sendMessage(json.encode(request.toJson()));
  }

  //{"id":"4e71af1b-cf97-4f36-ba9d-6e15779591af","command":"do.action","payload":{"action_id":8,"device_id":1}}
  Future<dynamic> doAction(int actionId, deviceId) async {
    Completer c = new Completer();
    final payload = new CommandDoAction(actionId: actionId, deviceId: deviceId);
    _command('do.action', payload, c);
    return c.future;
  }
}
