
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasks/Views/add_activity.dart';
import 'package:tasks/Views/Create.dart';
import 'package:tasks/Views/user_info.dart';
import 'package:tasks/generated/assets.dart';
import 'package:tasks/main.dart';
import '../Controller/dope.dart';
import 'add_work_side.dart';


late SharedPreferences shared;
var isfirst = shared.getBool('isFirst');

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  shared = await SharedPreferences.getInstance();
  runApp( GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Dope(),
    theme: ThemeData(fontFamily: 'Cairo-medium'),
    initialRoute: isfirst == false ?  '/main' : '/dope',
    getPages: [
      GetPage(name: '/',        page: ()  => const Dope()),
      GetPage(name: '/main',    page: ()  => const Main() ),
      GetPage(name: '/create',  page: ()  => const create()),
      GetPage(name: '/addTask', page: ()  => const Add_activity()),
      GetPage(name: '/addSide', page: ()  => const Add_side()),
      GetPage(name: '/userInfo', page: () => const User_info())
    ],
  ));
}



class Dope extends StatelessWidget {
  const Dope({super.key});

  @override
  Widget build(BuildContext context) {
    PageController Controller = PageController();


    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(0, 1),
          child: Container(color: Colors.white),
        ),

        body: GetBuilder<Dopecontroller>(
          init: Dopecontroller(),
          builder: (controller) {
            return Stack(
              children: [
                PageView(
                  controller: Controller,
                  onPageChanged: (value) {
                    if(value == 2 ){
                      Get.offNamed('/create');
                    }
                  },
                  children: [
                    Stack(
                      children: [
                        Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('نظم عملك    ' , style: TextStyle(fontSize: 33 , fontFamily: 'Cairo-medium'),),
                                const Divider(color: Colors.transparent,height: 50,),
                                Image.asset(Assets.assetsTasks , width: 330,)
                              ],
                            )
                        ),

                      ],
                    ),

                    Container(
                      color: const Color(0xffffffff),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 814,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('كن اكثر نجاحا' , style: TextStyle(fontSize: 33 , fontFamily: 'Cairo-medium'),),
                                const Divider(color: Colors.transparent,height: 50,),
                                Image.asset(Assets.assetsSuccess , width: 330,)
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 814,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('نظم عملك   ' , style: TextStyle(fontSize: 33 , fontFamily: 'Cairo-medium'),),
                                const Divider(color: Colors.transparent,height: 50,),
                                Image.asset(Assets.assetsFirstDope , width: 330,)
                              ],
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),

                Container(
                  alignment: const Alignment(0, .9),
                  child: SmoothPageIndicator(controller: Controller,
                    count: 3 ,
                    effect: const WormEffect(radius: 6 ,dotWidth: 25 , dotHeight: 10 ,dotColor: Colors.white ,activeDotColor: CupertinoColors.activeGreen),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: const Color(0xfff2e5e5),
                      width: 80,
                      height: 40,
                      child: TextButton(
                         style: ButtonStyle(
                           overlayColor: MaterialStatePropertyAll(Colors.transparent)
                         ),
                        child: const Text('تخطئ' , style: TextStyle(color: Colors.black, fontSize: 16),),
                        onPressed: () {
                          Get.offNamed('/create');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        )
    );
  }
}

