/*
 * This file is part of the Smart Home
 * Program complex distribution https://github.com/e154/smart-home-app
 * Copyright (C) 2016-2020, Filippov Alex
 *
 * This library is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see
 * <https://www.gnu.org/licenses/>.
 */

import 'dart:async';
import 'dart:convert';

import 'package:smart_home_app/common/common.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/repositories/server_stream/command.dart';
import 'package:smart_home_app/repositories/server_stream/command_get_workflow_states.dart';
import 'package:smart_home_app/repositories/server_stream/request.dart';
import 'package:smart_home_app/repositories/server_stream/response.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'command_do_action.dart';
import 'command_get_devices_states.dart';

class ServerStream {
  IOWebSocketChannel _channel;
  bool _cancelOnError;
  bool _isClosed;
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
    _isClosed = false;
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
    _isClosed = true;
    _channel.sink.close(status.normalClosure);
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
          v.complete(response);
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
    if (!_isClosed) {
      _tryConnect();
    }
  }

  _sendMessage(dynamic data) {
    _channel.sink.add(data);
  }

  _command(Command command, Completer c) {
    var uuid = new Uuid().v4();
    final request =
        new Request(id: uuid, command: command.command(), payload: command);
    _pool[uuid] = c;
    _sendMessage(json.encode(request.toJson()));
  }

  //{"id":"4e71af1b-cf97-4f36-ba9d-6e15779591af","command":"do.action","payload":{"action_id":8,"device_id":1}}
  Future<dynamic> doAction(int actionId, deviceId) async {
    Completer c = new Completer();
    final command = new CommandDoAction(actionId: actionId, deviceId: deviceId);
    _command(command, c);
    return c.future;
  }

  //{"id":"a16e244e-19db-42d6-9136-d67e6970bb97","command":"map.get.devices","payload":{}}
  Future<dynamic> getDevicesStates() async {
    Completer c = new Completer();
    final command = new CommandGetDevicesStates();
    _command(command, c);
    return c.future;
  }

  //{"id":"a16e244e-19db-42d6-9136-d67e6970bb97","command":"workflow.get.status","payload":{}}
  Future<dynamic> getWorkflowStates() async {
    Completer c = new Completer();
    final command = new CommandGetWorkflowStates();
    _command(command, c);
    return c.future;
  }
}
