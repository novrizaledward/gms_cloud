import 'dart:convert';

import 'package:gms_cloud/repository/respone/modelLoginRespone.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageConstant {
  static const String loginInfo = 'USER_INFO';
}

class StorageManager {
  static SharedPreferences? _sharedPreferences;

  static Future<SharedPreferences?> get _pref async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences;
  }

  static Future<bool> setLoginModel(dynamic data) async {
    if (data == null) {
      return (await _pref)!.setString(StorageConstant.loginInfo, data);
    }
    return (await _pref)!
        .setString(StorageConstant.loginInfo, jsonEncode(data));
  }

  static Future<Data?> getLoginModel() async {
    var stringData = (await _pref)!.get(StorageConstant.loginInfo);

    if (stringData == null) {
      return null;
    }
    return Data.fromJson(jsonDecode(stringData.toString()));
  }

  static Future<bool> get isLogin async {
    return (await getLoginModel()) != null;
  }

  static Future<bool> setLogout() async {
    return (await _pref)!.remove(StorageConstant.loginInfo);
  }
}
