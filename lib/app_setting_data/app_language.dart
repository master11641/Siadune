import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localizations.dart';

class AppLanguage {
  Locale _appLocale ;
  Locale get appLocal => _appLocale ?? Locale("fa");
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('fa');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    return Null;
  }

  final _local = BehaviorSubject<Locale>();
  Function(Locale) get inLocal => _local.sink.add;
  Stream<Locale> get outLocal => _local.stream;
  AppLanguage() {
    print(' — — — -AppLanguage BLOC INIT — — — — ');
  }
  dispose() {
    print(' — — — — -AppLanguage BLOC DISPOSE — — — — — -');
    _local.close();
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("fa")) {
      _appLocale = Locale("fa");
      await prefs.setString('language_code', 'fa');
      await prefs.setString('countryCode', 'IR');
      GetIt.instance.get<AppLocalizations>().locale = _appLocale;
      await GetIt.instance.get<AppLocalizations>().load();
      inLocal(_appLocale);
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
      GetIt.instance.get<AppLocalizations>().locale = _appLocale;
      await GetIt.instance.get<AppLocalizations>().load();
      inLocal(_appLocale);
    }
  }
}
