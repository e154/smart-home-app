import 'package:http_interceptor/http_interceptor.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/common/main_state.dart';
import 'package:smart_home_app/models/models.dart';

import '../constants.dart';

class ServerInterceptor implements InterceptorContract {
  final MainState mainState = new MainState();

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    Settings settings = MainState.get().settings;

    data.url = settings.serverAddress + BASE_PATH + data.url;

    if (data.headers["Authorization"] == null) {
      data.headers["Authorization"] = MainState.get().currentUserToken;
    }

    if (data.headers["ServerAuthorization"] == null) {
      data.headers["ServerAuthorization"] = settings.accessToken;
    }

    if (data.headers["Content-Type"] == null) {
      data.headers["Content-Type"] = "application/json";
    }

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    return data;
  }
}
