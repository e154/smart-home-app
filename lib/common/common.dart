export 'main_state.dart';

String ignoreSubMicro(String s) {
  if (s.length > 27) return s.substring(0, 26) + s[s.length - 1];
  return s;
}