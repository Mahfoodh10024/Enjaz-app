import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:tasks/Controller/user.dart';
import 'package:tasks/Views/dope.dart';

import '../functions.dart';
import '../Widgets/Button.dart';

class User_info extends StatelessWidget {
  const User_info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),


      body: ListView(
        padding: const EdgeInsets.only(top: 60),
        children: [
          GetBuilder<User>(
            init: User(),
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('الاسم')],
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    width: 270,
                    child: TextFormField(
                      onTap: () {},
                      controller: controller.nameController,
                      readOnly: false,
                      style: const TextStyle(fontFamily: 'Cairo-medium'),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "لا يمكن ترك الحقل فارغ ";
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        // hintText: 'التاريخ',
                        // hintStyle: TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium')
                      ),
                    ),
                  ),
                  const Divider(
                    height: 50,
                    color: Colors.transparent,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('الهاتف')],
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    width: 270,
                    child: TextFormField(
                      onTap: () {},
                      controller: controller.phoneController,
                      readOnly: false,
                      style: const TextStyle(fontFamily: 'Cairo-medium'),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "لا يمكن ترك الحقل فارغ ";
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        // hintText: 'التاريخ',
                        // hintStyle: TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium')
                      ),
                    ),
                  ),
                  const Divider(
                    height: 50,
                    color: Colors.transparent,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('الايميل')],
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    width: 270,
                    child: TextFormField(
                      onSaved: (newValue) {
                        print(newValue);
                      },
                      onTap: () {},
                      controller: controller.emailController,
                      readOnly: false,
                      style: const TextStyle(fontFamily: 'Cairo-medium'),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "لا يمكن ترك الحقل فارغ ";
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        // hintText: 'التاريخ',
                        // hintStyle: TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium')
                      ),
                    ),
                  ),
                  const Divider(
                    height: 50,
                    color: Colors.transparent,
                  ),

                  CustomButton(
                    widget: const Text(
                      'تحديث',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'newfont'),
                    ),
                    color: controller.selectedColor,
                    onpress: () async {
                      methods().customdialog(context: context, anime:  AnimType.scale,type:  DialogType.success, btColor:  Colors.green, body:  const Center(child: Text('تم التحديث'  , style: TextStyle(fontFamily:'Cairo-medium' ,fontSize: 22))), press: () {  } );
                      await controller.Updateemail([controller.emailController.text]);
                      shared.setString('name', controller.nameController.text);
                      shared.setString('email', controller.emailController.text);
                      shared.setString('phone', controller.phoneController.text);
                    },
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// if(res <= 0){
//   shared.setString('name', controller.nameController.text);
//   shared.setString('email', controller.emailController.text);
//   shared.setString('phone', controller.phoneController.text);
//   print('Updated');
// }