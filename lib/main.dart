import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siadune/blocs/theme_bloc.dart';
import './blocs/adver_bloc.dart';
import './blocs/bloc_provider.dart';
import './blocs/goods_bloc.dart';
import './blocs/store_bloc.dart';
import './blocs/user_bloc.dart';
import 'package:flutter/services.dart';
import './tools/route_generator.dart';
import 'app_setting_data/app_language.dart';
import 'app_setting_data/app_theme.dart';
import 'app_setting_data/localizations.dart';
const String ACCESS_TOKEN = "pk.eyJ1IjoibWFzdGVyMTE2NDEiLCJhIjoiY2tkYWR1NDNkMGN5MTJxbXoydDZoaWFiYyJ9.sp3sVaNqQP8UJ6BAh2lmpA";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton<ThemeBloc>(ThemeBloc());
  GetIt.instance.registerSingleton<StoreBloc>(StoreBloc());
   GetIt.instance.registerSingleton<AppLanguage>(AppLanguage());
  debugPrintRebuildDirtyWidgets = false;
  AppTheme currentTheme = await getCurrentTheme();
  return runApp(BlocProvider<AdverBloc>(
    bloc: AdverBloc(),
    child: BlocProvider<StoreBloc>(
      bloc: StoreBloc(),
      child: BlocProvider<GoodsBloc>(
        bloc: GoodsBloc(),
        child: BlocProvider<UserBloc>(
          bloc: UserBloc(),
          child: MyApp(
            appTheme: currentTheme,
          ),
        ),
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  final AppTheme appTheme;

  const MyApp({Key key, this.appTheme}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamBuilder(
        initialData: widget.appTheme,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: Locale("fa"),
            supportedLocales: [
              Locale('fa', 'IR'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
           theme: snapshot.hasData
                    ? _buildThemeData(snapshot.data)
                    : ThemeData(),
            // home: SplashScreenPage(),
            initialRoute: '/',
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        });
  }
}
  _buildThemeData(AppTheme appTheme) {
    return ThemeData(
        brightness: appTheme.theme.brightness,
        primarySwatch: appTheme.theme.primarySwatch,
        primaryColor: appTheme.theme.primaryColor,
        tabBarTheme: appTheme.theme.tabBarTheme,
        textTheme: appTheme.theme.textTheme,
        // accentColor: Colors.white,
        buttonTheme: appTheme.theme.buttonThemeData,
        // dialogBackgroundColor: Colors.orange,
        //dialogTheme: DialogTheme(elevation: 10,backgroundColor: CustomColor.primaryColor),
        inputDecorationTheme: appTheme.theme.inputDecorationTheme);
  }

Future<AppTheme> getCurrentTheme() async {
  ThemeBloc appbloc = GetIt.instance.get<ThemeBloc>();
  var prefs = await SharedPreferences.getInstance();
  AppTheme currentTheme;
  var themeName = prefs.getString('current_theme') ?? "Default";
  currentTheme = myThemes.firstWhere((x) => x.name.contains(themeName));
  appbloc.theme.sink.add(currentTheme);
  return currentTheme;
}
