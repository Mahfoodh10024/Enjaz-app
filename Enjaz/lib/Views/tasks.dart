import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tasks/Controller/activity.dart';
import 'package:tasks/Views/Taskinfo.dart';
import '../functions.dart';
import '../generated/assets.dart';
import 'dope.dart';


class Taskspage extends StatefulWidget {
  const Taskspage({super.key});

  @override
  State<Taskspage> createState() => _TaskspageState();
}

class _TaskspageState extends State<Taskspage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: PreferredSize(
          preferredSize: const Size(100, 100),
          child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(right: 100 ,left: 10),

              //ترتيب المهام
              child: GetBuilder<Task>(
                init: Task('','','','','','','',''),
                builder: (controller) {
                  return DropdownButton<String>(
                    underline: Container(height: 0 ,width: 0,color: Colors.transparent),
                    icon: SvgPicture.asset(Assets.iconsArrange, width: 30),
                    elevation: 1,
                    items: const [
                      DropdownMenuItem(value: "priority", child: Text("الاولويه")),
                      DropdownMenuItem(value: "activity_date", child: Text("التاريخ")),
                      DropdownMenuItem(value: "activity_name", child: Text("الاسم")),
                      DropdownMenuItem(value: "activity_time", child: Text("الوقت"))
                    ],
                    onChanged:(value) {
                      if( value == 'priority'){
                        shared.setString('priority', value.toString());
                      } else if (value == 'activity_date'){
                        shared.setString('priority', value.toString());
                        controller.update();
                      } else if(value == 'activity_name'){
                        shared.setString('priority', value.toString());
                        controller.update();
                      } else if (value == 'activity_time'){
                        shared.setString('priority', value.toString());
                        controller.update();
                      } else{}
                    },
                  );
                },
              )
          ),
        ),


        body: GetBuilder<Task>(
          init: Task("", "", "", "", "",'','',''),
          builder: (controller) {
            return ListView(
              shrinkWrap: true,
              children: [

                //المهام المتاخره
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: const EdgeInsets.only(top: 20),
                  child: Card(
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8 , left: 8),
                      child: Text('المتاخره' , style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: FutureBuilder<List<Task>>(
                    future: Task("", "", "", "", "",'','','').overdueTasks(),
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: task.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              onUpdate: (details) {},
                              onDismissed: (direction) async {
                                if(direction == DismissDirection.startToEnd){
                                  var res =await controller.finished(activity_name: task[index].name , activity_type: task[index].type , activity_date: task[index].date, activity_time: task[index].time, activity_day: task[index].day, priority: task[index].priority ,work_side: task[index].work_side ,achieved: task[index].achieved);
                                  if(res>0){controller.delete(task[index].name,'activity');}
                                } else if(direction == DismissDirection.endToStart) {
                                  var res =await controller.deleted(activity_name: task[index].name , activity_type: task[index].type , activity_date: task[index].date, activity_time: task[index].time, activity_day: task[index].day, priority: task[index].priority ,work_side: task[index].work_side ,achieved: task[index].achieved);
                                  if(res>0){controller.delete(task[index].name,'activity');}
                                }
                              },
                              secondaryBackground: Container(alignment: Alignment.centerRight ,padding: const EdgeInsets.only(right: 30), width: 20 ,height: 20 , child: const Icon(Icons.delete , color: Colors.red,)),
                              background: Container(alignment: Alignment.centerLeft , padding: const EdgeInsets.only(left: 30),width: 20 ,height: 20 , child: const Icon(Icons.done ,color: Colors.green)),
                              key: UniqueKey(),
                              child:  Container(
                                  width: double.infinity,
                                  height: 80,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color(0xb0ff0000),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    onTap:  () {
                                      Get.to(Info(name: Text(task[index].name , style: TextStyle(color: controller.selectedColor)) ,
                                          data: task[index].name, isEnable: false,
                                          msg:'لا يمكن التعديل بسبب إنتهاء وقت المهمه',
                                          table: 'activity'));
                                    },
                                    child: ListTile(
                                      title:  Text(task[index].date.substring(0,10),style: TextStyle(color: Colors.white),),
                                      subtitle:  Text(task[index].time ,style: TextStyle(color: Colors.white),),
                                      leading: Text(task[index].name , style: const TextStyle(fontSize: 20 , color: Colors.white)),
                                    ),
                                  )
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {return const Divider(color: Colors.transparent,height: 20,);},
                        );
                      } else if(!snapshot.hasData == false){
                        return const Center(child: Text('no Data' , style: TextStyle(fontSize: 25,color: Colors.blueAccent),),);
                      }  else {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      }
                    },
                  ),
                ),

                //المهام اليوم
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: const EdgeInsets.only(top: 120),
                  child: Card(
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8 ,top: 8),
                      child: Text('جاري' , style: TextStyle(fontSize: 20),),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: FutureBuilder<List<Task>>(
                    future: Task("", "", "", "", "",'','','').todayTasks(),
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: task.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              onUpdate: (details) {},
                              onDismissed: (direction) async {

                                if(direction == DismissDirection.startToEnd){
                                  var res =await controller.finished(activity_name: task[index].name , activity_type: task[index].type , activity_date: task[index].date, activity_time: task[index].time, activity_day: task[index].day, priority: task[index].priority ,work_side: task[index].work_side ,achieved: task[index].achieved);
                                  if(res>0){controller.delete(task[index].name,'activity');}
                                } else if(direction == DismissDirection.endToStart) {
                                  var res =await controller.deleted(activity_name: task[index].name , activity_type: task[index].type , activity_date: task[index].date, activity_time: task[index].time, activity_day: task[index].day, priority: task[index].priority ,work_side: task[index].work_side ,achieved: task[index].achieved);
                                  if(res>0){controller.delete(task[index].name,'activity');}
                                }
                              },
                              secondaryBackground: Container(alignment: Alignment.centerRight ,padding: const EdgeInsets.only(right: 30), width: 20 ,height: 20 , child: const Icon(Icons.delete , color: Colors.red,)),
                              background: Container(alignment: Alignment.centerLeft , padding: const EdgeInsets.only(left: 30),width: 20 ,height: 20 , child: const Icon(Icons.done ,color: Colors.green)),
                              key: UniqueKey(),
                              child:  Container(
                                  width: double.infinity,
                                  height: 80,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: controller.selectedColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    onTap:  () {
                                      Get.to(Info(name: Text(task[index].name , style: TextStyle(color: controller.selectedColor))
                                          ,data: task[index].name, isEnable: true, msg: '', table: 'activity'));
                                    },
                                    child: ListTile(
                                      title: const Text("اليوم",style: TextStyle(color: Colors.white),),
                                       subtitle:  Text(task[index].time ,style: const TextStyle(color: Colors.white),),
                                      leading: Text(task[index].name , style: const TextStyle(fontSize: 20 , color: Colors.white)),
                                    ),
                                  )
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {return const Divider(color: Colors.transparent,height: 20,);},
                        );
                      } else if (!snapshot.hasData){
                        return Center(child: Text('no Data'),);
                      } else {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      }
                    },
                  ),
                ),

                //مهام الغد
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: const EdgeInsets.only(top: 150),
                  child: Card(
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8 , left: 8),
                      child: Text('غدا',style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: FutureBuilder<List<Task>>(
                    future: Task("", "", "", "", "",'','','').tomorrowTasks(),
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: task.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              onUpdate: (details) {},
                              onDismissed: (direction) async {

                                if(direction == DismissDirection.startToEnd){
                                  var res =await controller.finished(activity_name: task[index].name , activity_type: task[index].type , activity_date: task[index].date, activity_time: task[index].time, activity_day: task[index].day, priority: task[index].priority ,work_side: task[index].work_side ,achieved: task[index].achieved);
                                  if(res>0){controller.delete(task[index].name,'activity');}
                                } else if(direction == DismissDirection.endToStart) {
                                  var res =await controller.deleted(activity_name: task[index].name , activity_type: task[index].type , activity_date: task[index].date, activity_time: task[index].time, activity_day: task[index].day, priority: task[index].priority ,work_side: task[index].work_side ,achieved: task[index].achieved);
                                  if(res>0){controller.delete(task[index].name,'activity');}
                                }
                              },
                              secondaryBackground: Container(alignment: Alignment.centerRight ,padding: const EdgeInsets.only(right: 30), width: 20 ,height: 20 , child: const Icon(Icons.delete , color: Colors.red,)),
                              background: Container(alignment: Alignment.centerLeft , padding: const EdgeInsets.only(left: 30),width: 20 ,height: 20 , child: const Icon(Icons.done ,color: Colors.green)),
                              key: UniqueKey(),
                              child:  Container(
                                  width: double.infinity,
                                  height: 80,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: controller.selectedColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    onTap:  () {
                                      Get.to(Info(name: Text(task[index].name , style: TextStyle(color: controller.selectedColor)) ,
                                          data: task[index].name, isEnable: false,
                                          msg: 'لا يمكن الاضافه قبل الموعد' ,
                                             table: 'activity',));
                                    },
                                    child: ListTile(
                                      subtitle:  Text(task[index].time ,style: TextStyle(color: Colors.white),),
                                      title: const Text("غدا",style: TextStyle(color: Colors.white),),
                                      leading: Text(task[index].name , style: const TextStyle(fontSize: 20 , color: Colors.white)),
                                    ),
                                  )
                              ),
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
                  ),
                ),

                //مهام اخرى
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: const EdgeInsets.only(top: 150),
                  child: Card(
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8 , left: 8),
                      child: Text('اخرى' , style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: FutureBuilder<List<Task>>(
                    future: Task("", "", "", "", "",'','','').comingTasks(),
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: task.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              onUpdate: (details) {},
                              onDismissed: (direction) async {

                                if(direction == DismissDirection.startToEnd){
                                  var res =await controller.finished(activity_name: task[index].name , activity_type: task[index].type , activity_date: task[index].date, activity_time: task[index].time, activity_day: task[index].day, priority: task[index].priority ,work_side: task[index].work_side ,achieved: task[index].achieved);
                                  if(res>0){controller.delete(task[index].name,'activity');}
                                } else if(direction == DismissDirection.endToStart) {
                                  var res =await controller.deleted(activity_name: task[index].name , activity_type: task[index].type , activity_date: task[index].date, activity_time: task[index].time, activity_day: task[index].day, priority: task[index].priority ,work_side: task[index].work_side ,achieved: task[index].achieved);
                                  if(res>0){controller.delete(task[index].name,'activity');}
                                }
                              },
                              secondaryBackground: Container(alignment: Alignment.centerRight ,padding: const EdgeInsets.only(right: 30), width: 20 ,height: 20 , child: const Icon(Icons.delete , color: Colors.red,)),
                              background: Container(alignment: Alignment.centerLeft , padding: const EdgeInsets.only(left: 30),width: 20 ,height: 20 , child: const Icon(Icons.done ,color: Colors.green)),
                              key: UniqueKey(),
                              child:  Container(
                                  width: double.infinity,
                                  height: 80,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: controller.selectedColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    onTap:  () {
                                      Get.to(Info(name: Text(task[index].name , style: TextStyle(color: controller.selectedColor))
                                          ,data: task[index].name, isEnable: false,
                                          msg:'لا يمكن الاضافه قبل الموعد' ,
                                             table:'activity',));
                                    },
                                    child: ListTile(
                                      subtitle: Text(task[index].day,style: TextStyle(color: Colors.white),),
                                      title:    Text(task[index].date.substring(0,10),style: TextStyle(color: Colors.white),),
                                      leading:  Text(task[index].name , style: const TextStyle(fontSize: 20 , color: Colors.white)),
                                    ),
                                  )
                              ),
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
                  ),
                ),
              ],
            );
          },
        )
    );

  }
}

