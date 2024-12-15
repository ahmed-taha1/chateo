import 'package:shared_preferences/shared_preferences.dart';

class CacheServiceConstants {
  static const String token = 'token';
  static const String pinHash = 'pinHash';
  static const String key = 'key';
  static const String language = 'language';
  static const String theme = 'theme';
  static const String isDark = 'isDark';
  static const String isLogged = 'isLogged';
  static const String tempPinToken = 'tempPinToken';
  static const String tempOtpToken = 'tempOtpToken';
  static const String phoneNumber = 'phoneNumber';
}

class CacheService {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required dynamic value,
  }) async {

    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }

  static void logout() async {
    await removeData(key: CacheServiceConstants.token);
    await removeData(key: CacheServiceConstants.pinHash);
    await removeData(key: CacheServiceConstants.isLogged);
    await removeData(key: CacheServiceConstants.tempPinToken);
    await removeData(key: CacheServiceConstants.tempOtpToken);
    await removeData(key: CacheServiceConstants.key);
    await removeData(key: CacheServiceConstants.phoneNumber);
  }
}