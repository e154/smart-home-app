import 'package:http/http.dart';
import 'package:meta/meta.dart';

class UserRepository {
  Client httpClient;

  UserRepository({@required this.httpClient}) : assert(httpClient != null);
}
