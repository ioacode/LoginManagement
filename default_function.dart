import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:shared_preferences/shared_preferences.dart';

String client_modif(String cliendId, int code) {
  var date = new DateTime.now().toUtc();
  var result = DateFormat("yyyy_HH_MM_dd").format(date);
  if (code == 1) {
    return cliendId + result;
  } else if (code == 2) {
    return result + cliendId;
  }
}

String generateMd5(String data) {
  return crypto.md5.convert(utf8.encode(data)).toString();
}

String genereteBase64(String data){
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  return stringToBase64.encode(data);
}

getSession(String code)async{
  final prefs = await SharedPreferences.getInstance(); 
  final token = prefs.getString(code) ?? ''; 
  return token;
}
