import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/user.dart';
import '../Controller/user_pref.dart';


class User_preferences extends StatefulWidget {
  const User_preferences({super.key});

  State<User_preferences> createState() => mystate();
}

class mystate extends State<User_preferences> {
  GlobalKey<FormState> FormState1 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

          body: GetBuilder<User>(
           init: User(),
            builder: (controller) {
              return ListView(
                children: [
                  ListTile(
                    onTap: () {
                      Get.toNamed('/userInfo');
                      controller.update();
                      controller.userData();
                    },
                    leading: const Icon(Icons.chevron_left, size: 40),
                    trailing: const Text("بيانات المستخدم", style: TextStyle(fontSize: 20),),
                  ),

                  const Divider(color: Colors.black,),
                  ListTile(
                    onTap: () =>  controller.pickColor(context),
                    leading: const Icon(Icons.chevron_left, size: 40),
                    trailing: const Text("لون التطبيق", style: TextStyle(fontSize: 20),),
                  ),

                  const Divider(color: Colors.black,),

                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.chevron_left, size: 40),
                    trailing: const Text("حول التطبيق", style: TextStyle(fontSize: 20),),
                  ),

                ],
              );
            },
          )
    );
  }
}


