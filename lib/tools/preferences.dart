import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static String get fontName => "IRANSansMobile";
  bool _isPreLoad = false;
  Future<bool> get isPreLoad async {    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPreLoad = (prefs.getBool('isPreLoad') ?? false);
    return isPreLoad;
  }
  
//  Future<bool> isPreLoad()  async  {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isPreLoad = (prefs.getBool('isPreLoad') ?? false);
//     return isPreLoad;
//   //  await prefs.setBool('isPreLoad', isPreLoad);
//   }
}
