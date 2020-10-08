
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siadune/app_setting_data/app_theme.dart';
import 'package:siadune/app_setting_data/preferences.dart';
class ThemeBloc {
  final theme = BehaviorSubject<AppTheme>();
  Function(AppTheme) get inTheme => theme.sink.add;
  Stream<AppTheme> get outTheme => theme.stream;
  
  ThemeBloc() {
    print('----Theme BLOC INIT----');
    outTheme.listen((onData) async{
      var prefs = await SharedPreferences.getInstance();
        await prefs.setString(Preferences.currentTheme, onData.name);
    });
  }
  dispose() {
    print('----APP BLOC DISPOSE----');
    theme.close();
  }
}