import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home_page.dart';

class UserPrefs {
  // static final UserPrefs _instance = UserPrefs._internal();
  static late SharedPreferences _prefs;
  static String? lastPages;
  // factory UserPrefs() {
  //   return _instance;
  // }
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  UserPrefs._internal();
  // SharedPreferences? _prefs;
  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? get lastPageG {
    print('lastPage: $lastPages');
    UserPrefs.lastPages = _prefs.getString("lastPage");
    return _prefs.getString('lastPage') ?? HomeScreen.routeName;
  }

  static set lastPage(String? page) {
    _prefs.setString('lastPage', page!);
    print('lastPage: $lastPages');
    print(page);
  }

  static List<String> getLastSearches() {
    return _prefs.getStringList("ultimasbusquedas") ?? [];
  }

  static setLastSearches(List<String> searches) {
    _prefs.setStringList("ultimasbusquedas", getLastSearches() + searches);
  }
}
