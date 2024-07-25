

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
//
// import '../../Controller/activity.dart';
// import '../Taskinfo.dart';
//
// class Tab1 extends StatelessWidget {
//   const Tab1({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GetBuilder<Task>(
//           init: Task("", "", "", "", "",'','',''),
//           builder: (controller) {
//
//             return FutureBuilder<List<Task>>(
//               future: Task("", "", "", "", "",'','','').getFinished(),
//               builder: (context, snapshot) {
//
//                 if (snapshot.hasData) {
//                   final task = snapshot.data!;
//
//                   return ListView.separated(
//                     itemCount: task.length,
//                     itemBuilder: (context, index) {
//                       return Dismissible(
//                         onUpdate: (details) {},
//                         onDismissed: (direction) async {
//                           if(direction == DismissDirection.startToEnd){
//                             // var res =await controller.finished(task[index].name, task[index].type, task[index].date, task[index].time, task[index].day, task[index].priority, task[index].work_side);
//                             // print(res);
//                           } else if(direction == DismissDirection.endToStart) {
//                             var res =await controller.deleted(task[index].name, task[index].type, task[index].date, task[index].time, task[index].day, task[index].priority, task[index].work_side, task[index].achieved);
//                             if(res>0){controller.deleteFinished(task[index].name);}
//                           }
//                         },
//                         secondaryBackground: Container(alignment: Alignment.centerRight ,padding: const EdgeInsets.only(right: 15), width: 20 ,height: 20 , child: const Icon(Icons.delete , color: Colors.red)),
//                         background: Container(alignment: Alignment.centerLeft , padding: const EdgeInsets.only(left: 30),width: 20 ,height: 20 , child: const Icon(Icons.done ,color: Colors.transparent)),
//                         key: UniqueKey(),
//                         child:  Container(
//                             width: double.infinity,
//                             height: 80,
//                             margin: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                                 color: Colors.green,
//                                 borderRadius: BorderRadius.circular(10)
//                             ),
//                             child: InkWell(
//                               onTap:  () {
//                                 Get.to(Info(data: task[index].name, isEnable: false, msg: '', name: Text(task[index].name), table: 'finished',));
//                               },
//                               child: ListTile(
//                                 title: Text(task[index].name , style: const TextStyle(fontSize: 20 , color: Colors.white)),
//                               ),
//                             )
//                         ),
//                       );
//                     },
//                     separatorBuilder: (BuildContext context, int index) {return const Divider(color: Colors.transparent,height: 20,);},
//                   );
//                 } else {
//                   return const Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Center(child: CircularProgressIndicator()),
//                     ],
//                   );
//                 }
//               },
//             );
//           },
//         )
//     );
//   }
// }
