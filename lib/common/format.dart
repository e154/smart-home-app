
String ignoreSubMicro(String s) {
//  print("-----");
//  print("before: " + s);
  if (s.length > 27) {
    if (s.contains("+")) {
      s = s.substring(0, 25) + "0Z";
    } else {
      s = s.substring(0, 26) + s[s.length - 1];
    }
  }

//  print("after: " +s);

  return s;
}