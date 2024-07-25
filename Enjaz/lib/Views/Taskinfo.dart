import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:tasks/Controller/awesomeNotification.dart';
import 'package:tasks/Views/dope.dart';
import 'package:tasks/Views/work_side_info.dart';
import '../Controller/activity.dart';
import '../Widgets/Button.dart';
import '../Widgets/Task_info.dart';
import '../functions.dart';

class Info extends StatelessWidget {
  const Info({super.key, this.data, required this.isEnable, required this.msg, required this.name, required this.table});

  final dynamic data;
  final bool isEnable ;
  final String msg;
  final  Widget name;
  final String table;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: name,
          toolbarHeight: 70,
        ),

        body: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: GetBuilder<Task>(
            init: Task('','','','','','','',''),
            builder: (controller) {

              return FutureBuilder<List<Task>>(
                future: controller.showTask(data , table),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    final task = snapshot.data!;



                    return ListView.separated(
                      itemCount: task.length,
                      itemBuilder: (context, index) {

                        var pr = task[index].priority;
                        if (pr == '1') {
                          pr = "عاليه";
                        } else if (pr == '2') {
                          pr = "متوسطه";
                        } else if (pr == '3') {
                          pr = "منخفضه";
                        } else {}

                        int year = int.parse(task[index].date.substring(0, 4));
                        int month = int.parse(task[index].date.substring(5,7));
                        int day = int.parse(task[index].date.substring(8,10));


                        controller.Name.text = task[index].name;
                        controller.Type.text = task[index].type;
                        controller.Date.text = task[index].date.substring(0,10);
                        controller.Day.text = task[index].day;
                        controller.Time.text = task[index].time;
                        controller.Side.text = task[index].work_side;
                        controller.Prioritycon.text = pr;
                        controller.Achieved.text = isEnable == false ? msg : task[index].achieved;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            inoflistTile(
                              controller: controller.Name,
                              colr: controller.selectedColor,
                              text1: 'الاسم',
                              Tap: () {
                                controller.updateDialog(context: context, controller: controller.Name, title: 'الاسم',readable: false,
                                press: () async {
                                  controller.update();
                                  var res = await controller.updateData('activity_name', controller.Name.text, task[index].name);
                                  Navigator.of(context).pop();
                                },
                                tap: () {}
                                );
                              },
                            ),

                            inoflistTile(
                              controller: controller.Type,
                              colr: controller.selectedColor,
                              text1: 'النوع',
                              Tap: () {
                                controller.updateDialog(context:context, controller: controller.Type, title: 'النوع', readable: false,
                                      press: () async {
                                          controller.update();
                                          var res = await controller.updateData('activity_type', controller.Type.text, task[index].name);
                                          Navigator.of(context).pop();
                                        },
                                        tap: () { }
                                );
                              },
                            ),

                            inoflistTile(
                              controller: controller.Date,
                              colr: controller.selectedColor,
                              text1: 'التاريخ',
                              Tap: () {
                                controller.updateDialog(context: context, controller: controller.Date,title: 'التاريخ',readable: true,
                                       press: () async {
                                       controller.update();
                                       var res = await controller.setDate(controller.Date.text, task[index].name , controller.selectedWeekDay.text);
                                       Navigator.of(context).pop();
                                        },
                                      tap: () {controller.pickdate(context, controller.Date);}
                                );
                              },
                            ),
                            inoflistTile(
                              controller: controller.Time,
                              colr: controller.selectedColor,
                              text1: 'الوقت',
                              Tap: () {
                                controller.updateDialog(context: context, controller: controller.Time, title: 'الوقت', readable: true,
                                        press: () async{
                                          controller.update();
                                          var res = await controller.updateData( 'activity_time' ,controller.Time.text, task[index].name);
                                          Navigator.of(context).pop();
                                        },
                                       tap: () { controller.picktime(context, controller.Time); }
                                );
                              },
                            ),


                            inoflistTile(
                              controller: controller.Day,
                              colr: controller.selectedColor,
                              text1: 'اليوم',
                              Tap: () {  },
                            ),

                            inoflistTile(
                              controller: controller.Side,
                              colr: controller.selectedColor,
                              text1: 'الجهه',
                              Tap: () {
                                Get.to(side_Info(data: controller.Side.text));
                              },
                            ),

                            inoflistTile(
                              controller: controller.Prioritycon,
                              colr: controller.selectedColor,
                              text1: 'الاولويه',
                              Tap: () {  },
                            ),

                            //إشعار
                            Visibility(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 170),
                                  child: FlutterSwitch(
                                    value: controller.isSwitchOn.value,
                                    activeColor: Colors.green,
                                    onToggle: (value) {
                                      if(value == true){
                                        shared.setBool('active', value);
                                        NotificationServices.Alert(title: task[index].name, body: 'لديك مهمه', year: year ,month: month , day: day);
                                      } else{
                                        shared.setBool('active', value);
                                      }
                                      controller.toggleSwitch();
                                      controller.update();
                                    },
                                  ),
                                ),
                                trailing: const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    'تذكير',
                                    style: TextStyle(color: Colors.black ,fontSize: 15),
                                  ),
                                ),
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.only(top: 38.0 , bottom: 30),
                              child: Text('التنفيذ'),
                            ),

                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 15 , right: 15),
                                  width: double.infinity,
                                  child: TextFormField(
                                    scrollController: ScrollController(initialScrollOffset: 0),
                                    enabled: isEnable,
                                    controller: controller.Achieved,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                      focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                      disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const Divider(color: Colors.transparent ,height: 20,),
                            Padding(
                              padding: const EdgeInsets.only(left: 20 , bottom: 20),
                              child: CustomButton(
                                widget: const Text(
                                  'تحديث',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: 'newfont'),
                                ),
                                color: controller.selectedColor,
                                onpress: () async {
                                  controller.update();
                                  var res = await controller.addAchieved(name: task[index].name, data: controller.Achieved.text);
                                  if(res > 0){
                                    methods().customdialog(context:  context, anime:  AnimType.scale, type: DialogType.success ,btColor:  Colors.green ,body: const Center(child: Text('تم الاضافه بنجاح' , style: TextStyle(fontFamily:'Cairo-medium' ,fontSize: 22))), press: () => '', );
                                  } else {
                                    methods().customdialog(context:  context, anime:  AnimType.scale, type: DialogType.error ,btColor:  Colors.red ,body: const Center(child: Text('لم يتم الاضافه' , style: TextStyle(fontFamily:'Cairo-medium' ,fontSize: 22))), press: () => '', );
                                  }
                                },
                              ),
                            )

                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {return const Divider(color: Colors.transparent,height: 20,);},
                    );
                  } else {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  }
                },
              );
            },
          ),
        )
    );
  }
}
