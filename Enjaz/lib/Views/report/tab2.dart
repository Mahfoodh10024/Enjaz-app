


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:tasks/functions.dart';

import '../../Controller/activity.dart';
import '../../Widgets/Button.dart';
import '../Taskinfo.dart';

class Tab2 extends StatelessWidget {
  const Tab2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: GetBuilder<Task>(
          init: Task("", "", "", "", "",'','',''),
          builder: (controller) {

            return ListView(
             shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: CustomButton(
                        widget: const Text('حذف الكل' , style: TextStyle(fontSize: 12 , color: Colors.white , fontFamily: 'newfont'),textAlign: TextAlign.center,) ,
                        onpress: () async{
                          controller.deleteallDeleted();
                          controller.update();
                        },
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

                FutureBuilder<List<Task>>(
                  future: Task("", "", "", "", "",'','','').getDeleted(),
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
                                var res = await controller.Insert(activity_name: task[index].name , activity_type: task[index].type , activity_date: task[index].date, activity_time: task[index].time, activity_day: task[index].day, priority: task[index].priority ,work_side: task[index].work_side ,achieved: task[index].achieved);
                                if(res > 0){
                                  controller.update();
                                  controller.delete(task[index].name,'deleted');
                                }
                              } else if(direction == DismissDirection.endToStart) {
                                print(4);
                                controller.update();
                                controller.delete(task[index].name, 'deleted');
                              }
                            },
                            secondaryBackground: Container(alignment: Alignment.centerRight ,padding: const EdgeInsets.only(right: 30), width: 20 ,height: 20 , child: const Icon(Icons.delete , color: Colors.red,)),
                            background: Container(alignment: Alignment.centerLeft , padding: const EdgeInsets.only(left: 30),width: 20 ,height: 20 , child: const Icon(CupertinoIcons.arrow_2_circlepath_circle ,color: Colors.green)),
                            key: UniqueKey(),
                            child:  Container(
                                width: double.infinity,
                                height: 80,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: InkWell(
                                  onTap:  () async {
                                    Get.to(Info(data: task[index].name ,isEnable: false ,msg: 'لا يمكن التعديل',name: Text(task[index].name), table: 'deleted',));
                                  },
                                  child: ListTile(
                                    title: Text(task[index].name , style: const TextStyle(fontSize: 20 , color: Colors.white)),
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
              ],
            );
          },
        )
    );
  }
}
