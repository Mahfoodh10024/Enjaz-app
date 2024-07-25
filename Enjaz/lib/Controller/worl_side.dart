import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/DB.dart';
import '../Views/dope.dart';

class Work_side_controller extends GetxController{


  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController locationcontroller = TextEditingController();
  TextEditingController infocontrller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();


  late final String name;
  late final String location;
  late final String description;
  late final String note;
  Work_side_controller(this.name, this.location , this.description , this.note);
  Work_side_controller.name(this.name);

  Color selectedColor = const Color(0xff3600b2);

  //loadDefaultColor from SharedPreferences
  void _loadDefaultColor() async {
    final savedColor = shared.getInt('defaultColor');
    if (savedColor != null) {
      selectedColor = Color(savedColor);
    }
  }


  @override
  void onInit() {
    super.onInit();
    update();
    _loadDefaultColor();
    getSide();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _loadDefaultColor();
    update();
  }



  //Add inserted data to Database('activity table')
  var user_Id = 1;
  Insert(String sideName ,String location , String note, String description ){
    update();
    var response =  dataBase().insertData("work_side" , {
      'user_id '      : user_Id      ,
      'work_side_name': sideName     ,
      'location'      : location     ,
      'note'          : note         ,
      'description'   : description
    });
    return response;
  }

  //display Task info from database
  Future<List<Work_side_controller>> getSide() async {
    update();
    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
    final List<Map<String, dynamic>> results = await db.query('work_side' , orderBy: 'work_side_name');
    return results.map((side) => Work_side_controller(
        side['work_side_name'] as String ,
        side['location']       as String ,
        side['description']    as String ,
        side['note']           as String
    )).toList();
  }




  Future<List<Work_side_controller>>showSides(String row) async {
    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
    final List<Map<String, dynamic>> results = await db.query('work_side' , where: 'work_side_name = ?' ,whereArgs: [row]);
    return results.map((side) => Work_side_controller(
        side['work_side_name'] as String ,
        side['location']       as String ,
        side['description']    as String ,
        side['note']           as String
    )).toList();
  }




  updateWorkSideTable(String workSideName, String location, String description, String note) async {
    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path

    const sql = '''
    UPDATE work_side
    SET work_side_name = ?,
         location = ?,
         description = ?,
         note = ?
    WHERE work_side_name = ?
  ''';

    // Prepare the arguments list with appropriate null handling
    final arguments = [
      workSideName,
      location ?? null, // Set to null if not provided
      description ?? null,
      note ?? null,
      workSideName, // Existing work_side_name for WHERE clause
    ];

    try {
     var res = db.rawUpdate(sql, arguments);
      return res;
    } catch (error) {
      return 0;
    }
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

  updateData(String row , String data , String name) async {
    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path
    var sql = '''
          UPDATE work_side SET  $row = ? WHERE work_side_name = ?
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

  deleteSide(String data) async {
    var res  =await  dataBase().deleteData(' DELETE FROM work_side WHERE work_side_name = ?' , [data] );
    return res;
  }


  read() async {
    var res =await dataBase().readData('SELECT * FROM work_side ');
    return res;
  }

}