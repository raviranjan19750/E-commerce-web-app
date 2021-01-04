import 'package:living_desire/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();
  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get data {
    return _prefs.getString('data') ?? '';
  }

  set data(String value) {
    _prefs.setString('data', value);
  }

  get authID {
    return _prefs.getString('data') ?? '';
  }

  Future setAuthID(String value) {
    return _prefs.setString('authID', value);
  }

  get AuthID {
    return _prefs.getString('authID');
  }

  // set WishlistData(String productNumber) {
  //   _prefs.setStringList("WishList", value);
  // }
}
