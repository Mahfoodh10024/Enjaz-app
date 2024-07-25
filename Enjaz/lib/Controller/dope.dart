import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tasks/Model/DB.dart';
import 'package:tasks/Views/dope.dart';
import 'package:tasks/main.dart';


const Color darkMain = Color(0xff303030);


class Dopecontroller extends GetxController{

  Color selectedColor = const Color(0xff3600b2);


  Future<Color> _loadDefaultColor() async {
    final savedColor = shared.getInt('defaultColor');
    if (savedColor != null) {
      selectedColor = Colors.white;
    }
    return selectedColor;
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dataBase().initailDatabase();
    _loadDefaultColor();
    shared.setString('priority', '1');
    if(shared.getBool('active') != null){
    } else {
      Intial();
    }
  }


  Intial(){
    shared.setString('name', 'name');
    shared.setString('email', 'email');
    shared.setString('phone', 'phone');
    shared.setBool('active', true);
  }



  ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(color: darkMain),
    drawerTheme: const DrawerThemeData(backgroundColor: darkMain),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: darkMain),
    buttonTheme: const ButtonThemeData(buttonColor: Colors.yellow),
    snackBarTheme:  const SnackBarThemeData(backgroundColor: darkMain),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(darkMain)
        )
    ),

    fontFamily: 'Cairo-req',
  );


  ThemeData light = ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(color: Colors.cyan),
      drawerTheme: const DrawerThemeData(backgroundColor: Colors.cyan),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.cyan),
      snackBarTheme:  const SnackBarThemeData(backgroundColor: Colors.cyan ,contentTextStyle: TextStyle(color: Colors.white)),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.cyan)
          )
      ),
      // textTheme: const TextTheme(
      //   bodyMedium: TextStyle(color: Colors.cyan),
      // ),

      fontFamily: 'Cairo-req'
  );



}


