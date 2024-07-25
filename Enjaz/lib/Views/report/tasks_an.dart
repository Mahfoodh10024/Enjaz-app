import 'package:d_chart/commons/config_render.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/decorator.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/commons/style.dart';
import 'package:d_chart/ordinal/pie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../Controller/activity.dart';
import '../../Widgets/Button.dart';
import '../Taskinfo.dart';

class Task_an extends StatelessWidget {
  const Task_an({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _date = TextEditingController();
    TextEditingController _date1 = TextEditingController();


    return Scaffold(
      body: GetBuilder<Task>(
        init: Task("", "", "", "", "",'','',''),
        builder: (controller) {

          var avg = controller.taskNum + controller.finishTasks / 2;

          List<OrdinalData> ordinalDataList = [
            OrdinalData(domain: 'المهام', measure: controller?.taskNum ??  1 , color: Colors.grey),
            OrdinalData(domain: 'المكتمل', measure: controller.finishTasks, color: Colors.green),
            OrdinalData(domain: 'المعلق', measure: controller.anotherTasks, color: Colors.blue),
          ];
          return  ListView(
            shrinkWrap: true,
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 110,
                      height: 100,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        color: const Color(0xffeef7fe),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('الهمام', style: TextStyle(color: Colors.black)),
                            Text(controller.taskNum.toString(), style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 100,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        color: const Color(0xffeef7fe),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('المكتمله', style: TextStyle(color: Colors.black)),
                            Text(controller.finishTasks.toString(), style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 100,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        color: const Color(0xffeef7fe),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('المعدل', style: TextStyle(color: Colors.black)),
                            Text(avg.toString(), style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                height: 300,
                margin: EdgeInsets.only(left: 5, right: 5),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  color: const Color(0xffeef7fe),
                  child: Row(
                    children: [

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        height: 100,
                        width: 55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  color: Colors.grey,
                                ),
                                const Text('المهام')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  color: Colors.green,
                                ),
                                Text('منتهيه')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  color: Colors.blueAccent,
                                ),
                                Text('معلقه')
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 235,
                        alignment: Alignment.center,
                        child: AspectRatio(
                          aspectRatio: 16 / 12,
                          child: DChartPieO(
                            data: ordinalDataList,
                            customLabel: (ordinalData, index) {
                              return "${ordinalData.domain}: ${ordinalData.measure}";
                            },
                            configRenderPie: ConfigRenderPie(
                              arcWidth: 30,
                              arcLabelDecorator: ArcLabelDecorator(
                                labelPosition: ArcLabelPosition.inside,
                                insideLabelStyle: const LabelStyle(color: Colors.transparent)
                              ),
                            ),
                            animate: true,

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

     
              Container(
                width: double.infinity,
                height: 500,
                margin: const EdgeInsets.only(left: 5 , right: 5 , top: 25),
                color: const Color(0xffeef7fe),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 18.0 , top: 20 , bottom: 10),
                          child: Text('المهام الكتمله' , style: TextStyle(fontSize: 20),),
                        )
                      ],
                    ),

                    GetBuilder<Task>(
                      init: Task("", "", "", "", "",'','',''),
                      builder: (controller) {

                        return FutureBuilder<List<Task>>(
                          future: Task("", "", "", "", "",'','','').getFinished(),
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
                                        // var res =await controller.finished(task[index].name, task[index].type, task[index].date, task[index].time, task[index].day, task[index].priority, task[index].work_side);
                                        // print(res);
                                      } else if(direction == DismissDirection.endToStart) {
                                        var res =await controller.deleted(activity_name: task[index].name , activity_type: task[index].type , activity_date: task[index].date, activity_time: task[index].time, activity_day: task[index].day, priority: task[index].priority ,work_side: task[index].work_side ,achieved: task[index].achieved);
                                        if(res>0){
                                          controller.deleteFinished(task[index].name);
                                          var res = controller.numberofTasks();
                                          var res1 = controller.numberofAnother();
                                          var res2 = controller.numberoffinshed();
                                        }
                                      }
                                    },
                                    secondaryBackground: Container(alignment: Alignment.centerRight ,padding: const EdgeInsets.only(right: 15), width: 20 ,height: 20 , child: const Icon(Icons.delete , color: Colors.red)),
                                    background: Container(alignment: Alignment.centerLeft , padding: const EdgeInsets.only(left: 30),width: 20 ,height: 20 , child: const Icon(Icons.done ,color: Colors.transparent)),
                                    key: UniqueKey(),
                                    child:  Container(
                                        width: double.infinity - 10,
                                        height: 80,
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: InkWell(
                                          onTap:  () {
                                            Get.to(Info(data: task[index].name, isEnable: false, msg: 'لا يمكن التعديل', name: Text(task[index].name), table: 'finished',));
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
                        );
                      },
                    ),
                  ],
                ),
              )

            ],
          );
        },
      )
    );
  }
}
//     body: GetBuilder<Task>(
//   init: Task("", "", "", "", "", '', '',''),
//   builder: (controller) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Divider(color: Colors.transparent),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//
//             FutureBuilder(
//               future: controller.numberofTasks(),
//               builder: (context, snapshot) {
//                 return Column(
//                   children: [Text('المهام : ${snapshot.data}' , style: const TextStyle(fontSize: 16),)],
//                 );
//               },
//             ),
//
//             FutureBuilder(
//               future: controller.numberoffinshed(),
//               builder: (context, snapshot) {
//                 return Column(
//                   children: [
//                     Container(
//
//                     ),
//                     Text('المنجزه : ${snapshot.data}' , style: const TextStyle(fontSize: 16 , color: Colors.green))],
//                 );
//               },
//             ),
//
//             FutureBuilder(
//               future: controller.numberofdeleted(),
//               builder: (context, snapshot) {
//                 return Column(
//                   children: [Text('المحذوفه : ${snapshot.data}' , style: const TextStyle(fontSize: 16 ,color: Colors.red))],
//                 );
//               },
//             ),
//
//           ],
//         ),
//
//         const Divider(height:30 , color: Colors.transparent),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 170,
//               height: 120,
//               child: GetBuilder(
//                 init: Task('','','','','','','',''),
//                 builder: (controller) {
//                   return Container(
//                     margin: const EdgeInsets.all(20),
//                     child: TextFormField(
//                       onTap: () {
//                         controller.pickdate(context , _date);
//                       },
//                       controller: _date,
//                       readOnly: true,
//                       style: const TextStyle(fontFamily: 'Cairo-medium'),
//                       keyboardType: TextInputType.name,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "لا يمكن ترك الحقل فارغ ";
//                         }
//                       },
//                       textAlign: TextAlign.center,
//                       decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'التاريخ',
//                           hintStyle: TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium')
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const Text('الى'),
//             SizedBox(
//               width: 150,
//               height: 120,
//               child: GetBuilder(
//                 init: Task('','','','','','','',''),
//                 builder: (controller) {
//                   return Container(
//                     margin: const EdgeInsets.all(25),
//                     child: TextFormField(
//                       onTap: () {
//                         controller.pickdate(context , _date1);
//                       },
//                       controller: _date1,
//                       readOnly: true,
//                       style: const TextStyle(fontFamily: 'Cairo-medium'),
//                       keyboardType: TextInputType.name,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "لا يمكن ترك الحقل فارغ ";
//                         }
//                       },
//                       textAlign: TextAlign.center,
//                       decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'التاريخ',
//                           hintStyle: TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium')
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const Text('من'),
//           ],
//         ),
//
//         ElevatedButton(
//           child: Text('show'),
//           onPressed: () async {
//             var r = await controller.getActivityNames(_date.text , _date1.text);
//             print(r);
//           },
//         ),
//
//       Container(
//         width: 400,
//         height: 100,
//         color: Colors.grey,
//         child: ListView.builder(
//         itemCount: controller.activities.length,
//         itemBuilder: (context, index) {
//           final activity = controller.activities[index];
//           return ListTile(
//               title: Text(activity['activity_name'],style: TextStyle(color: Colors.red ,fontSize: 20),));
//         }
//       )
//       )
//
//    ],
//     );
//   },
// ));