import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:smart_home_app/common/common.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/repositories/server_stream/payload.dart';
import 'package:smart_home_app/repositories/server_stream/request.dart';
import 'package:smart_home_app/repositories/server_stream/response.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

import 'command_do_action.dart';

class ServerStream {
  IOWebSocketChannel channel;
  bool cancelOnError;
  Map pool;

  ServerStream() {
    pool = new Map();
  }

  connect() {
    _tryConnect();
  }

  _tryConnect() {
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
      channel.stream.listen(_onData,
          onError: _onError, onDone: _onDone, cancelOnError: cancelOnError);
    } catch (e) {}
  }

  close() {
    channel.sink.close();
  }

  _onData(dynamic data) {
    Map<String, dynamic> dataJson = jsonDecode(data);
    final response = Response.fromJson(dataJson);

    bool exist;
    pool.forEach((k, v) {
      if (k == response.id) {
        exist = true;
        v(response.status);
      }
    });

    if (exist) {
      pool.remove(response.id);
    }
  }

  _onError(dynamic data) {
    print('onError: ' + data.toString());
  }

  _onDone() async {
    await Future.delayed(Duration(seconds: 1));
    _tryConnect();
  }

  _sendMessage(dynamic data) {
    channel.sink.add(data);
  }

  _command(String command, Payload payload, Function fn) {
    var uuid = new Uuid().v4();
    final request = new Request(id: uuid, command: command, payload: payload);
    pool[uuid] = fn;
    _sendMessage(json.encode(request.toJson()));
  }

  //{"id":"4e71af1b-cf97-4f36-ba9d-6e15779591af","command":"do.action","payload":{"action_id":8,"device_id":1}}
  //{"id":"4e71af1b-cf97-4f36-ba9d-6e15779591af","command":"","payload":{},"forward":"response","status":"success","type":""}
  Future<String> doAction(int actionId, deviceId) {
    return new Future<String>(() {
      final payload =
          new CommandDoAction(actionId: actionId, deviceId: deviceId);
      _command('do.action', payload, (String status) {
        return status;
      });

      return "";
    });
  }
}
