import 'package:shared_preferences/shared_preferences.dart';

class LocalSharePrefarences {
  static late final SharedPreferences pref;
  LocalSharePrefarences._create(SharedPreferences preferences) {
    pref = preferences;
  }
  static create() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return LocalSharePrefarences._create(pref);
  }

  static void setPref(bool value) {
    pref.setBool('theme', value);
  }

  static bool getPref() {
    return pref.getBool('theme') ?? false;
  }
}
