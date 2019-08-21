import 'package:http_interceptor/http_interceptor.dart';
import 'package:smart_home_app/common/main_state.dart';

class Interceptor implements InterceptorContract {
  final MainState mainState = new MainState();

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    try {
      print('request ' + data.url);
    } catch (e) {
      print(e);
    }

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data);
    return data;
  }
}
