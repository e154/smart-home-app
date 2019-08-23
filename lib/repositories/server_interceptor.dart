import 'package:http_interceptor/http_interceptor.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/common/main_state.dart';
import 'package:smart_home_app/models/models.dart';

import '../constants.dart';

class ServerInterceptor implements InterceptorContract {
  final MainState mainState = new MainState();

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    Settings settings = await Adaptors.get().variable.getSettings();

    data.url = settings.serverAddress + BASE_PATH + data.url;
    data.headers["Authorization"] = MainState.get().currentUserToken;
    data.headers["ServerAuthorization"] = settings.accessToken;
    data.headers["Content-Type"] = "application/json";

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {

    return data;
  }
}
