import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ignorebatteryoptimization/flutter_ignorebatteryoptimization.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/Views/dope.dart';
import '../Model/DB.dart';
import '../functions.dart';
import 'awesomeNotification.dart';


class Task extends GetxController{


  final TextEditingController Name = TextEditingController();
  final TextEditingController Type = TextEditingController();
  TextEditingController Date = TextEditingController();
  final TextEditingController Day = TextEditingController();
  TextEditingController Time = TextEditingController();
  TextEditingController Prioritycon = TextEditingController();
  TextEditingController Achieved = TextEditingController();
  TextEditingController Side = TextEditingController();



  var actvie = Colors.white;
  late RxBool isSwitchOn = false.obs;
  int Weekday = 0;
  int priorityValue = 0;
  String? selectedpriority;
  TextEditingController selectedWeekDay = TextEditingController();

  late final String priority;
  late final String name;
  late final String type;
  late final String date;
  late final String time;
  late final String day;
  late final String work_side;
  late final String achieved;
  Task(this.name, this.type , this.day , this.time , this.date, this.priority , this.work_side , this.achieved);

  final List<String> Priority = ['عاليه','متوسطه','منخفضه'];


  // تحويل الاولويه من نص الى رقم
  prioritytoInt(){
    if(selectedpriority.toString() == 'عاليه'){
     return priorityValue = 1;
    } else if (selectedpriority.toString() == 'متوسطه'){
      return priorityValue = 2;
    } else {
      return priorityValue = 3;
    }
  }


  //تحميل اللون
  Color selectedColor = const Color(0xff3600b2);
  void _loadDefaultColor() async {
    final savedColor = shared.getInt('defaultColor');
    if (savedColor != null) {
      selectedColor = Color(savedColor);
    }
    update();
  }


  @override
  void onInit() {
    super.onInit();
    update();
    _loadDefaultColor();
    fetchData();
    toggleSwitch();
    numberofAnother();
    numberoffinshed();
    numberofTasks();
    comingTasks();
    todayTasks();
    overdueTasks();
    tomorrowTasks();
    NotificationServices.initializeNotification();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _loadDefaultColor();
    update();
    fetchData();
    numberofAnother();
    numberoffinshed();
    numberofTasks();
  }

  //زر الاشعارات
  void toggleSwitch() {
    isSwitchOn.value = !isSwitchOn.value;
    final savedstate = shared.getBool('active');
    isSwitchOn.value = savedstate!;
  }


  //إضاقة المهمام الى قائمة المهام
   var user_Id = 1;
   Insert({required String activity_name ,required String activity_type ,required String activity_date ,required String activity_time , required String activity_day ,required  String priority ,required  String work_side ,required  String achieved}){
     update();
   var response =  dataBase().insertData("activity" , {
       'user_id '     : user_Id      ,
      'activity_name': activity_name ,
      'activity_type': activity_type ,
      'activity_date': activity_date ,
      'activity_time': activity_time ,
      'priority'     : priority      ,
      'activity_day' : activity_day  ,
      'work_side'    : work_side     ,
      'achieved'     : achieved
    });
    return response;
  }


  //المهام المتاخره
  Future<List<Task>> overdueTasks() async {
    final late = DateTime.now().subtract(const Duration(days: 2));
    var pr = shared.get('priority');

    var sql = '''
    SELECT *
    FROM activity
    WHERE activity_date = ?  OR activity_date < ?
    ORDER BY $pr ASC
  ''';

    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
    final List<Map<String, dynamic>> results = await db.rawQuery(sql , [late.toString() , late.toIso8601String()]);
    update();
    return results.map((task) => Task(
        task['activity_name']  as String ,
        task['activity_type']  as String ,
        task['activity_day']   as String ,
        task['activity_time']  as String ,
        task['activity_date' ] as String ,
        task['priority']       as String ,
        task['work_side']      as String ,
        task['achieved']       as String
    )).toList();
  }

  //المهام اليوم
  Future<List<Task>> todayTasks() async {
    var or = shared.get('priority');
    final today = DateTime.now();
    final late = DateTime.now().subtract(const Duration(days: 2));


    var sql = '''
    SELECT *
    FROM activity
    WHERE activity_date > ?  AND activity_date <= ?
    ORDER BY $or ASC
  ''';

    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
    final List<Map<String, dynamic>> results = await db.rawQuery(sql , [late.toIso8601String() , today.toIso8601String()]);
    update();
    return results.map((task) => Task(
     task['activity_name']  as String ,
     task['activity_type']  as String ,
     task['activity_day']   as String ,
     task['activity_time']  as String ,
     task['activity_date' ] as String ,
     task['priority']       as String ,
     task['work_side']      as String ,
     task['achieved']       as String

    )).toList();
  }

  //مهام الغد
  Future<List<Task>> tomorrowTasks() async {
    var or = shared.get('priority');
    final today = DateTime.now();
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    var sql = '''
    SELECT *
    FROM activity
    WHERE  activity_date > ? AND activity_date <= ?
    ORDER BY $or ASC

  ''';

    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
    final List<Map<String, dynamic>> results = await db.rawQuery(sql ,  [today.toIso8601String(), tomorrow.toIso8601String() ]);
    update();
    return results.map((task) => Task(
        task['activity_name']  as String ,
        task['activity_type']  as String ,
        task['activity_day']   as String ,
        task['activity_time']  as String ,
        task['activity_date' ] as String ,
        task['priority']       as String ,
        task['work_side']      as String ,
        task['achieved']       as String
    )).toList();
  }

  //المهام اليوم
  Future<List<Task>> comingTasks() async {
    final today = DateTime.now();
    final afterTomorrow = today.add(const Duration(days: 2));
    var or = shared.get('priority');



    var sql = '''
    SELECT *
    FROM activity
    WHERE activity_date >= ?
    ORDER BY $or ASC

  ''';

    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
    final List<Map<String, dynamic>> results = await db.rawQuery(sql , [afterTomorrow.toString()]);
    update();
    return results.map((task) => Task(
        task['activity_name']  as String ,
        task['activity_type']  as String ,
        task['activity_day']   as String ,
        task['activity_time']  as String ,
        task['activity_date' ] as String ,
        task['priority']       as String ,
        task['work_side']      as String ,
        task['achieved']       as String
    )).toList();
  }


  //قراءة المهمام من قائمة المنجزه
  Future<List<Task>>showTask(String row , String table) async {
    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
    final List<Map<String, dynamic>> results = await db.query(table , where: 'activity_name = ?' ,whereArgs: [row]);
    return results.map((task) => Task(
        task['activity_name'] as String ,
        task['activity_type'] as String ,
        task['activity_day'] as String ,
        task['activity_time'] as String ,
        task['activity_date' ] as String ,
        task['priority']      as String ,
        task['work_side']     as String ,
        task['achieved']      as String
    )).toList();
  }

  //جذف المهمام من قائمة المهام
  delete(String data , String table){
    var res  = dataBase().deleteData(' DELETE FROM $table WHERE activity_name = ?' , [data] );
    print(res);
  }


  //إضافة المهمام الى قائمة المنجزه
  finished({required String activity_name ,required String activity_type ,required String activity_date ,required String activity_time , required String activity_day ,required  String priority ,required  String work_side ,required  String achieved}){
    var response =  dataBase().insertData("finished" , {
      'activity_name': activity_name ,
      'activity_type': activity_type ,
      'activity_date': activity_date ,
      'activity_time': activity_time ,
      'priority'     : priority      ,
      'activity_day' : activity_day  ,
      'work_side'    : work_side     ,
      'achieved'     : achieved
    });
    return response;
  }


  //قراءة المهمام من قائمة المنجزه
  Future<List<Task>> getFinished() async {
    update();
    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
    final List<Map<String, dynamic>> results = await db.query('finished' , orderBy: 'activity_name');

    return results.map((task) => Task(
        task['activity_name'] as String ,
        task['activity_type'] as String ,
        task['activity_day'] as String ,
        task['activity_time'] as String ,
        task['activity_date' ] as String ,
        task['priority']      as String ,
        task['work_side']     as String ,
        task['achieved']      as String
    )).toList();

  }


  //جذف المهمام من قائمة المنجزه
  deleteFinished(String data){
    var res  = dataBase().deleteData(' DELETE FROM finished WHERE activity_name = ?' , [data] );
    print(res);
  }


  //إضافة المهمام الى قائمة المحذوفات
  deleted({required String activity_name ,required String activity_type ,required String activity_date ,required String activity_time , required String activity_day ,required  String priority ,required  String work_side ,required  String achieved}) async {
    var response = await dataBase().insertData("deleted" , {
      'activity_name': activity_name ,
      'activity_type': activity_type ,
      'activity_date': activity_date ,
      'activity_time': activity_time ,
      'priority'     : priority      ,
      'activity_day' : activity_day  ,
      'work_side'    : work_side     ,
      'achieved'     : achieved
    });
    return response;
  }


  //قراءة المهمام الى قائمة المحذوفات
  Future<List<Task>> getDeleted() async {
    update();
    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
    final List<Map<String, dynamic>> results = await db.query('deleted' , orderBy: 'activity_name');

    return results.map((task) => Task(
        task['activity_name'] as String ,
        task['activity_type'] as String ,
        task['activity_day'] as String ,
        task['activity_time'] as String ,
        task['activity_date' ] as String ,
        task['priority']      as String ,
        task['work_side']     as String ,
        task['achieved']      as String
    )).toList();

  }


  //جذف المهمام من قائمة المحذوفات
  deleteDeleted(String data){
    var res  = dataBase().deleteData(' DELETE FROM deleted WHERE activity_name = ?' , [data] );
    print(res);
  }

  //جذف المهمام من قائمة المحذوفات
  deleteallDeleted(){
    var res  = dataBase().deleteAll(' DELETE FROM deleted ');
    print(res);
    update();
  }


  var taskNum = 0;
  //غدد المهام
  numberofTasks() async {
    final db = await openDatabase('/data/data/com.example.tasks/databases/User');
    const sql = '''
    SELECT COUNT(*) FROM activity
    ''';
    final List<Map<String, dynamic>> results = await db.rawQuery(sql);
    if(results.isEmpty){
      return 0;
    }
    taskNum = results.first['COUNT(*)'] as int;
    update();
    return taskNum.toInt();
  }


  var finishTasks = 0;
  //غدد المهام المنجزه
  numberoffinshed() async {
    final db = await openDatabase('/data/data/com.example.tasks/databases/User');
    const sql = '''
    SELECT COUNT(*) FROM finished
    ''';
    final List<Map<String, dynamic>> results = await db.rawQuery(sql);
    if(results.isEmpty){
      return 0;
    }
    finishTasks = results.first['COUNT(*)'] as int;
    update();
    return finishTasks.toInt();
  }


  var anotherTasks = 0;
  //غدد المهام المحذوفه
  numberofAnother() async {
    final db = await openDatabase('/data/data/com.example.tasks/databases/User');
    final tomorrow = DateTime.now().add(Duration(days: 1));

    const sql = '''
    SELECT COUNT(*) FROM activity WHERE  activity_date >= ?
 
    ''';
    final List<Map<String, dynamic>> results = await db.rawQuery(sql , [tomorrow.toString()]);
    if(results.isEmpty){
      return 0;
    }
     anotherTasks = results.first['COUNT(*)'] as int;
    update();
    return anotherTasks.toInt();
  }

  read() async {
    var res = await dataBase().readData('SELECT * FROM "deleted" ');
    return res;
  }


  //عرض جهة العمل عند إنشاء مهمه
  String? selectedValue;
  List<DropdownMenuItem<String>> items = [];
  Future<void> fetchData() async {
    final List<Map<String, dynamic>> results = await dataBase().Query('work_side');
    items = results.map<DropdownMenuItem<String>>((row) {
      return DropdownMenuItem<String>(
        alignment: Alignment.center,
        value: row['work_side_name'].toString(),
        child: Text(row['work_side_name']),
      );
    }).toList();
    update();
  }

  List<Map<String, dynamic>> activities = []; // List to store retrieved activities


  //
  Future<List<Map<String, dynamic>>> getActivityNames(String fromDate, String toDate) async {
    update();
      final db = await openDatabase('/data/data/com.example.tasks/databases/User');
    const String query = '''
     SELECT activity_name
    FROM activity
    WHERE activity_date BETWEEN ? AND ?
    ORDER BY activity_date ASC
  ''';

    final List<dynamic> arguments = [fromDate, toDate];

    final List<Map<String, dynamic>> results = await db.rawQuery(query, arguments);
    return activities = results;
  }



  //ديالوج الوقت
  picktime(BuildContext context , TextEditingController input) async {

    final TimeOfDay? pickeTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 22),

      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: selectedColor, // تغيير لون الزر الرئيسي
              onPrimary: Colors.white, // تغيير لون النص في الزر الرئيسي
              onSurface: selectedColor, // تغيير لون النص في الزر الثانوي
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (pickeTime != null) {
      input.text = "${pickeTime.hour}:${pickeTime.minute} ${pickeTime.period.name == 'am' ? 'صباحا':'مساء'}";
    }
  }

  //ديالوج التاريخ
  pickdate(BuildContext context , TextEditingController input) async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(const Duration(days: 3652)),
      type: OmniDateTimePickerType.date,
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: selectedColor,
          onPrimary: Colors.white,
          onSurface: selectedColor,
        )
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
    );

    if (dateTime != null) {
      input.text = dateTime.toIso8601String();
      Weekday = dateTime.weekday;
      if(Weekday == 1){
        selectedWeekDay.text = 'الإثنين';
      } else if( Weekday == 2){
       selectedWeekDay.text = 'الثلاثاء';
      } else if( Weekday == 3){
        selectedWeekDay.text = 'الأربعاء';
      } else if( Weekday == 4){
        selectedWeekDay.text = 'الخميس';
      } else if( Weekday == 5){
        selectedWeekDay.text = 'الجمعة';
      } else if( Weekday == 6 ){
        selectedWeekDay.text = 'السبت';
      } else if( Weekday ==  7){
        selectedWeekDay.text = 'الأحد';
      }
      print(Weekday);
      print(selectedWeekDay.text);
    }
  }


  //تحديث المهام
  // updateactivityTable({required String name, required String type, required String date, required String day , required String time , required String achieved , required String priority}) async {
  //   final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
  //    update();
  //   const sql = '''
  //   UPDATE activity
  //   SET  achieved = ? ,
  //        activity_name = ?,
  //        activity_type = ?,
  //        activity_date = ?,
  //        activity_day = ? ,
  //        activity_time =? ,
  //        priority = ?
  //   WHERE activity_name = ?
  // ''';
  //
  //   // Prepare the arguments list with appropriate null handling
  //   final arguments = [
  //     achieved,
  //     name,
  //     type , // Set to null if not provided
  //     date ,
  //     day  ,
  //     time ,
  //     priority,
  //     name
  //   ];
  //
  //   try {
  //     var res = db.rawUpdate(sql, arguments);
  //     return res;
  //   } catch (error) {
  //     return error;
  //   }
  // }

  //إضافة المنجز
  addAchieved({required String name ,required String data}){
    var res = dataBase().update('UPDATE activity SET achieved = ? WHERE activity_name = ? ' , [data ,name]);
    return res;
  }


  updateDialog({required BuildContext context , required TextEditingController controller , required String title , required bool readable , required VoidCallback press ,required VoidCallback tap}){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(child: Text(title)),
        content: Container(
          alignment: Alignment.center,
          width: 300,
          height: 200,
          child: TextFormField(
            onTap: () {tap();},
            readOnly: readable,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent))
            ),
            controller: controller,
          ),
                ),
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
                  child: const Text("تحديث",
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
                  child: const Text("إالغاء",
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


  setDate(String date , String name , String day) async {
    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
    var sql = '''
          UPDATE activity SET  activity_date = ? , activity_day =?  WHERE activity_name = ?
      ''';
    var res = db.rawUpdate(sql , [date , day , name]);
    return res;
  }

  updateData(String row , String data , String name) async {
    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
    var sql = '''
          UPDATE activity SET  $row = ? WHERE activity_name = ?
      ''';
    var res = db.rawUpdate(sql , [data , name]);
    return res;
  }

  unique(BuildContext context , String msg ){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg , style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    ));
  }



  deleALL(){
    var r = dataBase().deleteAll('DELETE FROM activity');
    return r;
  }


}