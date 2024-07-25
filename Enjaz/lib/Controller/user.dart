import 'dart:ffi';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ignorebatteryoptimization/flutter_ignorebatteryoptimization.dart';
import 'package:get/get.dart';
import 'package:iglu_color_picker_flutter/widgets/hue_ring_picker.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/Model/DB.dart';
import 'package:tasks/Views/dope.dart';

import '../functions.dart';

class User extends GetxController{

  int Selectedipage = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Color selectedColor = const Color(0xff3600b2);

  //loadDefaultColor from SharedPreferences
  void _loadDefaultColor() async {
    final savedColor = shared.getInt('defaultColor');
    if (savedColor != null) {
      selectedColor = Color(savedColor);
    }
  }

@override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    update();
    userData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userData();
    _loadDefaultColor();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _loadDefaultColor();
    userData();
  }


  Insert({required String table , required String name , required String email ,required String phone}){
    var response = dataBase().insertData("user" , {
      'name': name,
      'phone': phone,
      'email':email
    });
    shared.setString('name', name);
    shared.setString('email', email);
    shared.setString('phone', phone);
    print(shared.getString('name'));
    return response;
  }


   Updateemail(List<String> email){
    dataBase().update(" UPDATE `user` SET `email` = ? WHERE `user`.`id` = 1" , email);
  }

  UpdateName(List<String> phone){
    dataBase().update(" UPDATE `user` SET `phone` = ? WHERE `user`.`id` = 1" , phone);
  }

  UpdatePhone(List<String> name){
    dataBase().update(" UPDATE `user` SET `name` = ? WHERE `user`.`id` = 1" , name);
  }


  userData(){
    update();
    nameController.text = shared.getString('name')!;
    phoneController.text = shared.getString('phone')!;
    emailController.text= shared.getString('email')!;
  }

  read() async {
    var res = await dataBase().readData('SELECT * FROM "user" ');
    print(res);
  }



  //Save user color
  void _saveDefaultColor() async {
    shared.setInt('defaultColor' , selectedColor.value);
    print('save');
  }



  pickColor(BuildContext context){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          width: 500,
          height: 450,
          alignment: Alignment.center,
          child: IGHueRingPicker(
            currentColor: selectedColor,
            inputBarBorderColor: Colors.transparent,
            alphaSliderBorderColor: Colors.transparent,
            areaRadius: 20,
            hueRingBorderWidth: 0,
            alphaSliderBorderWidth: 0,
            alphaSliderRadius: 5,
            areaBorderColor: Colors.transparent,
            areaBorderWidth: 5,
            onColorChanged: (color) {
              selectedColor = color;
              update();
            },
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _saveDefaultColor();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],

      ),
    );
  }


  //التحقق من تحسين البطاريه
  final _flutterIgnorebatteryoptimizationPlugin = FlutterIgnorebatteryoptimization();
  Future<void>  openIgnorebatteryoptimizationPlugin() async {
    String ignoreBatteryOptimization;
    try {
      ignoreBatteryOptimization = await _flutterIgnorebatteryoptimizationPlugin.showIgnoreBatteryOptimizationSettings() ?? 'Unknown ignoreBatteryOptimization';
    } on PlatformException {
      ignoreBatteryOptimization = 'Failed to show ignoreBatteryOptimization.';
    }
    if (!true) return;
  }

  //طلب إذن تحسين البطاريه
  Future<void> openIsBatteryOptimizationDisabledPlugin(BuildContext context) async {
    String? isBatteryOptimizationDisabled;
    //print("isBatteryOptimizationDisabled: $isBatteryOptimizationDisabled");
    try {
      isBatteryOptimizationDisabled = await _flutterIgnorebatteryoptimizationPlugin.isBatteryOptimizationDisabled() == true ? "Disabled" : "Enabled";
    } on PlatformException {
      isBatteryOptimizationDisabled = 'Failed to show ignoreBatteryOptimization.';
    }
    print(isBatteryOptimizationDisabled);
    if(isBatteryOptimizationDisabled == 'Disabled') {
      methods().customDialog1(context , () {
        openIgnorebatteryoptimizationPlugin().then((value) => Navigator.pop(context));
        }
      );
    }
  }



}