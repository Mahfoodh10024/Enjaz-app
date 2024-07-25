import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/Controller/worl_side.dart';
import 'package:tasks/Views/work_side_info.dart';

class Work_sides extends StatelessWidget {
  const Work_sides({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: GetBuilder<Work_side_controller>(
          init: Work_side_controller('', '', '', ''),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder<List<Work_side_controller>>(
                future: Work_side_controller("",'','','').getSide(),
                builder: (context, snapshot) {

                  if(snapshot.hasData){
                    final side = snapshot.data!;
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: side.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          onUpdate: (details) {},
                          onDismissed: (direction) async {
                            if(direction == DismissDirection.endToStart){
                              var res = await controller.deleteSide(side[index].name);
                              if(res > 0){
                                controller.deleteSide(side[index].name);
                              }
                            }
                          },
                          secondaryBackground: Container(alignment: Alignment.centerRight ,padding: const EdgeInsets.only(right: 20), width: 20 ,height: 20 , child: Icon(CupertinoIcons.delete , color: Colors.red,)),
                          background: const SizedBox(width: 20 ,height: 20 , child: Icon(CupertinoIcons.delete ,color: Colors.red,)),
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
                                  Get.to(() => side_Info(data: side[index].name));
                                  print(side[index].name);
                                },
                                child: ListTile(
                                  title: Text(side[index].name , style: const TextStyle(fontSize: 20 , color: Colors.white)),
                                ),
                              )
                          ),
                        );

                      },
                      separatorBuilder: (BuildContext context, int index) {return const Divider(color: Colors.transparent,height: 20,);},
                    );

                  } else{
                    return  const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  }

                },
              ),
            );
          },
        )
    );
  }
}

