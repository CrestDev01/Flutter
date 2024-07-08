import 'package:shared_preferences/shared_preferences.dart';

class PreferenceKeys {
  static const String isLogin = "isLogin";
  static const String userData = "userData";
  static const String userFullName = "userFullName";
  static const String userImage = "userImage";
  static const String userRole = "userRole";
  static const String authToken = "authToken";
  static const String credentials = "credentials";
  static const String isRemember = "isRemember";
  static const String email = "email";
  static const String password = "password";
  static const String roleId = "roleId";
  static const String categories = "categories";
  static const String recentSearches = 'recentSearches';
  static const String cartItems = 'cartItems';
  static const String selectedLanguage = 'selectedLanguage';
  static const String savedEmails = 'savedEmails';
}

class PreferenceUtils {
  static PreferenceUtils? _instance;

  PreferenceUtils._internal() {
    _instance = this;
  }

  factory PreferenceUtils() => _instance ?? PreferenceUtils._internal();

  static PreferenceUtils get shared => PreferenceUtils();

  late SharedPreferences _sharedPreferences;

  setSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static initSharedPrefs() async {
    await PreferenceUtils.shared.setSharedPreferences();
  }
}

extension PrefExt on PreferenceUtils {
  //Set String
  setString({required String key, required String value}) async {
    await _sharedPreferences.setString(key, value);
  }

  //Get String
  String? getString({required String key}) {
    String? value = _sharedPreferences.getString(key);
    return value;
  }

  //Set Int
  setInt({required String key, required int value}) async {
    await _sharedPreferences.setInt(key, value);
  }

  getInt({required String key}) {
    int value = _sharedPreferences.getInt(key) ?? 0;
    return value;
  }

  //Set Boolean
  setBoolean({required String key, required bool value}) async {
    await _sharedPreferences.setBool(key, value);
  }

  //Get Boolean
  bool getBoolean({required String key}) {
    bool value = _sharedPreferences.getBool(key) ?? false;
    return value;
  }

  //Clear all data
  void clearAll() {
    _sharedPreferences.clear();
  }

  //Remove key
  void removeKey({required String key}) {
    _sharedPreferences.remove(key);
  }

  void setList({required String key, required List<String> value}) async {
    await _sharedPreferences.setStringList(key, value);
  }

  List<String>? getList({required String key}) {
    List<String>? value = _sharedPreferences.getStringList(key);
    return value;
  }
}
