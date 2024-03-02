import 'dart:convert' show utf8;

String utf8Encode(String value) {
  return utf8.decode(value.codeUnits);
}