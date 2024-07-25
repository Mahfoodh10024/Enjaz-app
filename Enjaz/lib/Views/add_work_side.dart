import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/Controller/activity.dart';
import 'package:tasks/Controller/worl_side.dart';
import 'package:tasks/functions.dart';
import 'package:tasks/Model/DB.dart';
import 'package:tasks/Test/c1.dart';
import '../Widgets/Button.dart';
import '../main.dart';
import 'dope.dart';

final TextEditingController _name = TextEditingController();
final TextEditingController _location = TextEditingController();
TextEditingController _info = TextEditingController();
TextEditingController _note = TextEditingController();

var maincolor = 0xff3600b2;

class Add_side extends StatefulWidget {
  const Add_side({super.key});

  State<Add_side> createState() => mystate();
}

class mystate extends State<Add_side> {
  GlobalKey<FormState> FormState1 = GlobalKey();


  Color selectedColor = const Color(0xff3600b2);

  //loadDefaultColor from SharedPreferences
  void _loadDefaultColor() async {
    final savedColor = shared.getInt('defaultColor');
    if (savedColor != null) {
      selectedColor = Color(savedColor);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadDefaultColor();
  }

  Map<String, String> data = {
    "work_side": _name.text,
  };


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          foregroundColor: selectedColor,
          backgroundColor: Colors.white,
          title: Text(
            "جهة عمل جديده",
            style: TextStyle(
                fontSize: 20, fontFamily: 'Cairo-medium', color: selectedColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: FormState1,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    margin: const EdgeInsets.all(27),
                    child: TextFormField(
                      controller: _name,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontFamily: 'Cairo-medium'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "لا يمكن ترك الحقل فارغ ";
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'اسم الجهه',
                          hintStyle: TextStyle(
                              fontSize: 20, fontFamily: 'Cairo-medium')),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(25),
                    child: TextFormField(
                      controller: _location,
                      style: const TextStyle(fontFamily: 'Cairo-medium'),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "لا يمكن ترك الحقل فارغ ";
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'موقع الجهه',
                          hintStyle: TextStyle(
                              fontSize: 20, fontFamily: 'Cairo-medium')),
                    ),
                  ),




                  Container(
                    margin: const EdgeInsets.all(25),
                    child: TextFormField(
                      controller: _info,
                      keyboardType: TextInputType.name,
                      readOnly: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "لا يمكن ترك الحقل فارغ ";
                        }
                      },
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: 'Cairo-medium'),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'معلومات عن الجهه',
                          hintStyle: TextStyle(
                              fontSize: 20, fontFamily: 'Cairo-medium')),
                    ),
                  ),


                  Container(
                    margin: const EdgeInsets.all(25),
                    child: TextFormField(
                      controller: _note,
                      keyboardType: TextInputType.name,
                      readOnly: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "لا يمكن ترك الحقل فارغ ";
                        }
                      },
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: 'Cairo-medium'),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ملاحظات',
                          hintStyle: TextStyle(
                              fontSize: 20, fontFamily: 'Cairo-medium')),
                    ),
                  ),


                  const Divider(
                    color: Colors.transparent,
                    height: 20,
                  ),

                  GetBuilder<Work_side_controller>(
                    init: Work_side_controller('', '', '',''),
                    builder: (controller) {
                      return CustomButton(
                        widget: const Text('إضافه', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'newfont'),),
                        color: controller.selectedColor,
                        onpress: () async {
                            controller.update();
                            try {
                              if (_name.text.isEmpty | _location.text
                                  .isEmpty | _info.text.isEmpty) {
                                methods().customdialog(context: context,
                                    anime: AnimType.scale,
                                    type: DialogType.error,
                                    btColor: Colors.red,
                                    body: const Center(child: Text(
                                        'يوجد حقل فارغ', style: TextStyle(
                                        fontFamily: 'Cairo-medium',
                                        fontSize: 22))),
                                    press: () {});
                              } else {
                                var res = await controller.Insert(
                                    _name.text,
                                    _location.text,
                                    _note?.text ?? 'غير محدد',
                                    _info.text
                                );
                                if (res > 0) {
                                  _name.clear();
                                  _location.clear();
                                  _info.clear();
                                  _note.clear();
                                  methods().customdialog(context: context,
                                      anime: AnimType.scale,
                                      type: DialogType.success,
                                      btColor: Colors.green,
                                      body: const Center(
                                          child: Text('تمت الاضافه بنجاح',
                                              style: TextStyle(
                                                  fontFamily: 'Cairo-medium',
                                                  fontSize: 22))),
                                      press: () {});
                                } else {
                                  methods().customdialog(context: context,
                                      anime: AnimType.scale,
                                      type: DialogType.warning,
                                      btColor: Colors.red,
                                      body: const Center(child: Text(
                                          'فشلت الاضافه', style: TextStyle(
                                          fontFamily: 'Cairo-medium',
                                          fontSize: 22))),
                                      press: () {});
                                }
                                print(res);
                              }
                            } catch(e){
                              if(e is DatabaseException && e.toString().contains('UNIQUE constraint failed')){
                                controller.unique(context, 'هذا الاسم موجود مسبقا');
                              } else{}
                            }
                        },
                      );
                    },
                  ),

                  // GetBuilder<Work_side_controller>(
                  //   init: Work_side_controller('', '', '', ''),
                  //   builder: (controller) {
                  //     return CustomButton(
                  //       widget: const Text('إضافي' , style: TextStyle(fontSize: 20 , color: Colors.white , fontFamily: 'newfont'),) ,
                  //       color:  Color(maincolor),
                  //       onpress: () async {
                  //         var re = await controller.showSides('afn');
                  //         print(re);
                  //       },
                  //     );
                  //   },
                  // ),

                ],
              ),
            ),
          ),
        ));
  }
}
