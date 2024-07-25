

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/Controller/worl_side.dart';

import '../Widgets/Button.dart';
import '../Widgets/Task_info.dart';
import '../Widgets/inputfield.dart';
import '../functions.dart';


class side_Info extends StatelessWidget {
  const side_Info({super.key, this.data});


  final dynamic data;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(),

        body: GetBuilder<Work_side_controller>(
          init: Work_side_controller('','','',''),
          builder: (controller) {

            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: FutureBuilder<List<Work_side_controller>>(
                future: controller.showSides(data),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    final side = snapshot.data!;

                    return ListView.separated(
                      itemCount: side.length,
                      itemBuilder: (context, index) {

                        controller.namecontroller.text = side[index].name;
                        controller.locationcontroller.text = side[index].location;
                        controller.notecontroller.text = side[index].note;
                        controller.infocontrller.text = side[index].description;


                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            inoflistTile(
                              controller: controller.namecontroller,
                              colr: controller.selectedColor,
                              text1: 'الاسم',
                              Tap: () {
                                controller.updateDialog(context:context, controller: controller.namecontroller, title: 'الاسم', readable: false,
                                press: () async {
                                  var res = await controller.updateData('work_side_name', controller.namecontroller.text, side[index].name);
                                  Navigator.of(context).pop();
                                  print(res);
                                },
                                tap: () { }
                                );
                              },
                            ),

                            inoflistTile(
                              controller: controller.locationcontroller,
                              colr: controller.selectedColor,
                              text1: 'الموقع',
                              Tap: () {
                                controller.updateDialog(context:context, controller: controller.locationcontroller, title: 'الموقع', readable: false,
                                    press: () async {
                                      var response = await controller.updateData('location', controller.locationcontroller.text, side[index].name);
                                      Navigator.of(context).pop();
                                      print(response);
                                    },
                                    tap: () { }
                                );
                              },
                            ),

                            inoflistTile(
                              controller: controller.notecontroller,
                              colr: controller.selectedColor,
                              text1: 'ملاحظات',
                              Tap: () {
                                controller.updateDialog(context:context, controller: controller.notecontroller, title: 'الملاحظات', readable: false,
                                    press: () async {
                                      controller.update();
                                      var res = await controller.updateData('note', controller.notecontroller.text, side[index].name);
                                      Navigator.of(context).pop();
                                    },
                                    tap: () { }
                                );
                              },
                            ),

                            inoflistTile(
                              controller: controller.infocontrller,
                              colr: controller.selectedColor,
                              text1: 'معلومات',
                              Tap: () {
                                controller.updateDialog(context:context, controller: controller.infocontrller, title: 'معلومات', readable: false,
                                    press: () async {
                                      controller.update();
                                      var res = await controller.updateData('description', controller.infocontrller.text, side[index].name);
                                      Navigator.of(context).pop();
                                    },
                                    tap: () { }
                                );
                              },
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {return const Divider(color: Colors.transparent,height: 20,);},
                    );
                  }else if(!snapshot.hasData){
                    return Text(snapshot.data.toString());
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
            );
          },
        )
    );
  }
}
