
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/Controller/activity.dart';
import 'package:tasks/functions.dart';
import 'package:tasks/Model/DB.dart';
import 'package:tasks/main.dart';
import '../Controller/dope.dart';
import '../Test/c1.dart';
import '../Widgets/Button.dart';
import 'dope.dart';



final TextEditingController _name = TextEditingController();
final TextEditingController _type = TextEditingController();
 TextEditingController _date = TextEditingController();
TextEditingController _time = TextEditingController();
var workSide = '11';


class Add_activity extends StatefulWidget {
  const Add_activity({super.key});

  State<Add_activity> createState() => mystate();
}

class mystate extends State<Add_activity> {
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
          appBar: AppBar(
             foregroundColor: selectedColor,
             backgroundColor: Colors.white,
             title: Text(
               "مهمه جديده",
               style: TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium' , color: selectedColor),
             ),
          ),

          body: Padding(
        padding: const EdgeInsets.all(15.0),
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
                        hintText: 'اسم المهمه',
                        hintStyle: TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium')
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(25),
                  child: TextFormField(
                    controller: _type,
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
                        hintText: 'نوع المهمه',
                        hintStyle: TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium')
                    ),
                  ),
                ),

                GetBuilder(
                  init: Task('','','','','','','',''),
                  builder: (controller) {
                    return Container(
                      margin: const EdgeInsets.all(25),
                      child: TextFormField(
                        onTap: () {
                          controller.pickdate(context , _date);
                          print(_date.text);
                        },
                        controller: _date,
                        readOnly: true,
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
                            hintText: 'التاريخ',
                            hintStyle: TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium')
                        ),
                      ),
                    );
                  },
                ),


                GetBuilder(
                  init: Task('','','','','','','',''),
                  builder: (controller) {
                    return Container(
                        width: 340,
                        height: 70,
                        margin: const EdgeInsets.all(25),
                        alignment: Alignment.center,

                        child: TextFormField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          controller: controller.selectedWeekDay,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'اليوم',
                              hintStyle: TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium')
                          ),
                        )
                    );
                  },
                ),


                GetBuilder(
                  init: Task('','','','','','','',''),
                  builder: (controller) {
                    return Container(
                      margin: const EdgeInsets.all(25),
                      child: TextFormField(
                        onTap: () {
                          controller.picktime(context, _time);
                        },
                        controller: _time,
                        keyboardType: TextInputType.name,
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "لا يمكن ترك الحقل فارغ ";
                          }
                        },
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontFamily: 'Cairo-medium'),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'الوقت',
                            hintStyle: TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium')
                        ),
                      ),
                    );
                  },
                ),


                GetBuilder(
                  init: Task('','','','','','','',''),
                  builder: (controller) {
                    return Container(
                      width: 340,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      margin: const EdgeInsets.all(25),
                      padding: const EdgeInsets.only(left: 5),
                      alignment: Alignment.center,

                      child: DropdownButton<String>(
                        value: controller.selectedpriority,
                        isExpanded: true,
                        alignment: Alignment.center,
                        underline: Container(height: 0 ,width: 0,color: Colors.transparent),
                        hint: const Text('الاولويه' ,textAlign: TextAlign.center),
                        style: const TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium' , color: Colors.black),
                        items: controller.Priority.map((String priority) {
                          return DropdownMenuItem<String>(
                            alignment: Alignment.center,
                            value: priority,
                            child: Text(priority),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            controller.selectedpriority = value;
                          });
                        },
                      ),
                    );
                  },
                ),

                GetBuilder<Task>(
                    init: Task('','','','','','','',''),
                    builder: (controller) {
                      return Container(
                        width: 340,
                        height: 70,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: DropdownButton<String>(
                          underline: Container(height: 0 ,width: 0,color: Colors.transparent),
                          alignment: Alignment.center,
                          value: controller.selectedValue,
                          isExpanded: true,
                          hint: const Text('جهة العمل'),
                          style: const TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium' ,color: Colors.black),
                          items: controller.items,
                          onChanged: (value) {
                            controller.selectedValue = value;
                            controller.update();
                          },
                        ),
                      );
                    }
                ),

                const Divider(
                  color: Colors.transparent,
                  height: 25,
                ),

                //زر الاضافه
                GetBuilder<Task>(
                  init: Task('','','','','','','',''),
                  builder: (controller) {
                    return CustomButton(
                      widget: const Text('إضافه' , style: TextStyle(fontSize: 20 , color: Colors.white , fontFamily: 'newfont'),) ,
                      color:  controller.selectedColor,
                      onpress: () async {
                        controller.update();
                        try{
                          if(_name.text.isEmpty | _type.text.isEmpty  | _date.text.isEmpty | _time.text.isEmpty ){
                            methods().customdialog(context: context, anime:  AnimType.scale,type:  DialogType.error, btColor:  Colors.red , body:  const Center(child: Text('يوجد حقل فارغ'  , style: TextStyle(fontFamily:'Cairo-medium' ,fontSize: 22))), press: () {  } );
                          } else{
                            var res = await controller.Insert(activity_name: _name.text, activity_type: _type.text, activity_date: _date.text, activity_time: _time.text, activity_day: controller.selectedWeekDay.text, priority: controller.prioritytoInt()?.toString() ?? "غير محدد" ,work_side: controller.selectedValue?.toString() ?? "غير محدد" ,achieved: 'فارغ');
                            if(res > 0){
                              _name.clear(); _type.clear();_date.clear();_time.clear();
                              methods().customdialog(context:  context, anime:  AnimType.scale, type: DialogType.success ,btColor:  Colors.green ,body: const Center(child: Text('تمت الاضافه بنجاح' , style: TextStyle(fontFamily:'Cairo-medium' ,fontSize: 22))), press: () {  } );
                            } else {
                              methods().customdialog(context: context, anime: AnimType.scale, type: DialogType.warning, btColor: Colors.red ,body: const Center(child: Text('فشلت الاضافه'  , style: TextStyle(fontFamily:'Cairo-medium' ,fontSize: 22))), press: () {  } );
                            }
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


                // GetBuilder<Task>(
                //   init: Task('', '', '', '', '', '', '', ''),
                //   builder: (controller) {
                //     return CustomButton(
                //       widget: const Text('إضافي' , style: TextStyle(fontSize: 20 , color: Colors.white , fontFamily: 'newfont'),) ,
                //       color:  CupertinoColors.destructiveRed,
                //       onpress: () async{
                //
                //         var res = await controller.read();
                //         print(res);
                //         // if(Get.isDarkMode){
                //         //   Get.changeTheme(controller.light);
                //         //   controller.update();
                //         // } else {
                //         //   Get.changeTheme(controller.dark);
                //         //   controller.update();
                //         // }
                //
                //         Get.to(MyApp());
                //       },
                //     );
                //   },
                // ),

              ],
            ),
          ),
        ),
      )
    );
  }
}
