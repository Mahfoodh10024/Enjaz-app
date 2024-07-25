import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tasks/Controller/user.dart';
import 'package:tasks/functions.dart';
import 'package:tasks/Views/dope.dart';
import 'package:tasks/Widgets/Button.dart';
import 'package:tasks/generated/assets.dart';
import 'package:tasks/main.dart';




TextEditingController _name = TextEditingController();
TextEditingController _phone = TextEditingController();
TextEditingController _email = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey();

class create extends StatelessWidget {
  const create({super.key});


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: ListView(
        shrinkWrap: true,
        children: [

          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 18.0 , bottom: 40),
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    margin: const EdgeInsets.only(top: 30 , bottom: 20),
                    child: Image.asset(Assets.assetsLogo , width: 10,height: 10,),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    height: 90,
                    width: 320,
                    child: TextFormField(
                      controller: _name,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'فارغ';
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          hintText: "الاسم",
                          hintStyle: TextStyle(fontFamily: 'Cairo-medium')
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 50 ),
                  child: SizedBox(
                    height: 90,
                    width: 320,
                    child: TextFormField(
                      controller: _phone,
                      textAlign: TextAlign.center,
                      maxLength: 12,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'فارغ';
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          hintText: "الهاتف",
                          hintStyle: TextStyle(fontFamily: 'Cairo-medium')
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: SizedBox(
                    height: 90,
                    width: 320,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'فارغ';
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),                          hintText: 'الايميل',
                          hintStyle: TextStyle(color: Colors.black, fontSize: 18.0)
                      ),
                          controller: _email,
                          textAlign: TextAlign.center,

                    )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only( top: 40),
                  child: GetBuilder<User>(
                    init: User(),
                    builder: (controller) {
                      return SizedBox(
                        width: 270,
                        height: 60,
                        child: CustomButton(
                          color: controller.selectedColor,
                          widget: const Text('تسجيل' , style: TextStyle(color: Colors.white ,fontSize: 20, fontFamily: 'newfont'),),
                          onpress: () async {
                            if(formKey.currentState!.validate()){print('فارغ');}
                            if(_name.text.isEmpty | _email.text.isEmpty | _phone.text.isEmpty) {
                              methods().customdialog(context: context, anime:  AnimType.scale,type:  DialogType.error, btColor:  Colors.red , body:  const Center(child: Text('يوجد حقل فارغ'  , style: TextStyle(fontFamily:'Cairo-medium' ,fontSize: 22))), press: () {  } );
                            }  else{
                              shared.setString('name', _name.text);
                              shared.setString('email', _email.text);
                              shared.setString('phone', _phone.text);
                              print(_name.text);
                              print(_email.text);
                              print(_phone.text);
                              var res =await controller.Insert(table: 'user' , email: _email.text , name: _name.text , phone: _phone.text);
                              _phone.clear();
                              _email.clear();
                              _name.clear();
                              if(res > 0){
                                shared.setBool('isFirst', false);
                                methods().customdialog(context:  context, anime:  AnimType.scale, type: DialogType.success ,btColor:  Colors.green ,body: const Center(child: Text('تم التسجيل بنجاح' , style: TextStyle(fontFamily:'Cairo-medium' ,fontSize: 22))),
                                press: () {Get.to(const Main()); shared.setBool('isFirst', false);} );
                              }
                            }
                          },
                        )
                      );

                    },
                  ),
                ),

              ],
            ),
          ),

        ],
      )
    );
  }
}
