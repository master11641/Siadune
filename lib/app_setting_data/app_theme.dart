

import 'package:flutter/material.dart';
import 'package:siadune/app_setting_data/colors.dart';

class MyTheme {
  Brightness brightness;
  MaterialColor primarySwatch;
  Color primaryColor;
  TextTheme textTheme;
  ButtonThemeData buttonThemeData;
  InputDecorationTheme inputDecorationTheme;
  TabBarTheme tabBarTheme;
  MyTheme(
      {this.brightness,
      this.primarySwatch,
      this.primaryColor,
      this.textTheme,
      this.buttonThemeData,
      this.inputDecorationTheme,
      this.tabBarTheme});
}

class AppTheme {
  String name;
  MyTheme theme;

  AppTheme(this.name, this.theme);
}

List<AppTheme> myThemes = [
  AppTheme(
      'Default',
      MyTheme(
          brightness: Brightness.light,
          primarySwatch: Colors.grey,
          primaryColor: CustomColor.lightGrey,
          textTheme: TextTheme(
              headline5: TextStyle(
                  color: CustomColor.grey,
                  fontFamily: 'IRANSansMobile',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal),
              bodyText2: TextStyle(
                  color: CustomColor.grey,
                  fontFamily: 'IRANSansMobile',
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal),
              headline6: TextStyle(
                  color: CustomColor.grey,
                  fontFamily: 'IRANSansMobile',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
              subtitle1: TextStyle(
                  color: CustomColor.grey,
                  fontFamily: 'IRANSansMobile',
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal),
              button: TextStyle(
                  color: Colors.white, fontFamily: 'IRANSansMobile')),
          buttonThemeData: ButtonThemeData(           
            buttonColor: CustomColor.primaryColor,
            textTheme:  ButtonTextTheme.primary,
   
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            //textTheme: ButtonTextTheme.accent,
          ),
          inputDecorationTheme: new InputDecorationTheme(
            fillColor: Color.fromRGBO(100, 140, 255, 1.0),
            filled: false,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          tabBarTheme: TabBarTheme(
            labelPadding: EdgeInsets.all(5.0),
            labelColor: CustomColor.primaryColor,
            unselectedLabelColor: Colors.black12,
          ))),
  AppTheme(
      'Teal',
      MyTheme(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
        textTheme: TextTheme(
            headline: TextStyle(
                color: CustomColor.nearlyDarkBlue,
                fontFamily: 'IRANSansMobile',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
            body1: TextStyle(
                color: CustomColor.nearlyDarkBlue,
                fontFamily: 'IRANSansMobile',
                fontSize: 14.0),
            button: TextStyle(
                color: Colors.white, fontFamily: 'IRANSansMobile')),
        buttonThemeData: ButtonThemeData(
          buttonColor: Color.fromRGBO(255, 213, 79, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          textTheme: ButtonTextTheme.primary,
        ),
        inputDecorationTheme: new InputDecorationTheme(
          fillColor: Color.fromRGBO(100, 140, 255, 1.0),
          filled: false,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelPadding: EdgeInsets.all(5.0),
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black12,
        ),
      )),
  AppTheme(
      'Orange',
      MyTheme(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange,
        textTheme: TextTheme(
            headline: TextStyle(
                color: CustomColor.nearlyDarkBlue,
                fontFamily: 'IRANSansMobile',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
            body1: TextStyle(
                color: CustomColor.nearlyDarkBlue,
                fontFamily: 'IRANSansMobile',
                fontSize: 14.0),
            button: TextStyle(
                color: Colors.white, fontFamily: 'IRANSansMobile')),
        buttonThemeData: ButtonThemeData(
          buttonColor: Color.fromRGBO(100, 140, 255, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          // textTheme: ButtonTextTheme.accent,
        ),
        inputDecorationTheme: new InputDecorationTheme(
          fillColor: Color.fromRGBO(100, 140, 255, 1.0),
          filled: false,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelPadding: EdgeInsets.all(5.0),
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black12,
        ),
      )),
  AppTheme(
      'Dark',
      MyTheme(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.black,
        textTheme: TextTheme(
            headline: TextStyle(
                color: Colors.white,
                fontFamily: 'IRANSansMobile',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
            body1: TextStyle(
                color: Colors.white,
                fontFamily: 'IRANSansMobile',
                fontSize: 14.0),
            button: TextStyle(
                color: Colors.white, fontFamily: 'IRANSansMobile')),
        buttonThemeData: ButtonThemeData(
          buttonColor: Color.fromRGBO(100, 140, 255, 1.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          // textTheme: ButtonTextTheme.accent,
        ),
        inputDecorationTheme: new InputDecorationTheme(
          fillColor: Color.fromRGBO(100, 140, 255, 1.0),
          filled: false,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelPadding: EdgeInsets.all(5.0),
          labelColor: CustomColor.nearlyDarkBlue,
          unselectedLabelColor: Colors.white,
        ),
      )),
];
