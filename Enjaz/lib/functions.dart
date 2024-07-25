import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ignorebatteryoptimization/flutter_ignorebatteryoptimization.dart';
import 'package:get/get.dart';
import 'package:iglu_color_picker_flutter/widgets/hue_ring_picker.dart';
import 'package:tasks/Views/dope.dart';

class methods{


  static message(BuildContext context){
    exit(0);
  }


  customDialog1(BuildContext context , VoidCallback press){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(' '),
        content: const Padding(
          padding: EdgeInsets.all(20),
          child: Text('برجى تمكين تجاهل حالة توفير شحن البطاريه ,حتى تتلقى الاشعارات في الوقت المحدد',textAlign:TextAlign.center,style: TextStyle(letterSpacing: 1),),
        ),
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Column(
            children: [
              SizedBox(
                width: 170,
                height: 45,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                      backgroundColor: MaterialStatePropertyAll(Color(
                          0xff4fa84f)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ))
                  ),
                  child: const Text("تمكين",
                      style: TextStyle(color: Colors.white , fontSize: 15 )
                  ),
                  onPressed: () {press();},
                ),
              ),

              const Divider(color: Colors.transparent),
              SizedBox(
                width: 170,
                height: 40,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                      overlayColor:  MaterialStatePropertyAll(Colors.transparent),
                      backgroundColor: MaterialStatePropertyAll(Color(0xffede7f3)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ))
                  ),
                  child: const Text("غير موافق",
                      style: TextStyle(color: Colors.grey , fontSize: 15 )
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  customdialog({required BuildContext context, required VoidCallback press , required AnimType anime , required DialogType type , required Color btColor , required Widget body}){
    return AwesomeDialog(
      context: context,
      animType: anime,
      dialogType: type,
      body: body,
      title: 'This is Ignored',
      desc:   'This is also Ignored',
      btnOkColor: btColor,
      btnOkOnPress: () {
        press();
      },
    )..show();
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
  }

  //طلب إذن تحسين البطاريه
  Future<void> openIsBatteryOptimizationDisabledPlugin() async {
    String? isBatteryOptimizationDisabled;
    //print("isBatteryOptimizationDisabled: $isBatteryOptimizationDisabled");
    try {
      isBatteryOptimizationDisabled = await _flutterIgnorebatteryoptimizationPlugin.isBatteryOptimizationDisabled() == true ? "Disabled" : "Enabled";
    } on PlatformException {
      isBatteryOptimizationDisabled = 'Failed to show ignoreBatteryOptimization.';
    }

    print(isBatteryOptimizationDisabled);
    if(isBatteryOptimizationDisabled == 'Disabled') {
      return openIgnorebatteryoptimizationPlugin();
    }
  }



}


