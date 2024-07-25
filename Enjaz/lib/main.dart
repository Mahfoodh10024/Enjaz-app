import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tasks/Controller/awesomeNotification.dart';
import 'package:tasks/Controller/user_pref.dart';
import 'package:tasks/Views/dope.dart';
import 'package:tasks/functions.dart';
import 'package:tasks/Views/report/reports.dart';
import 'package:tasks/Views/tasks.dart';
import 'package:tasks/Views/work_sides.dart';
import './generated/assets.dart';
import 'Controller/activity.dart';
import 'Controller/user.dart';
import 'Views/user_pref.dart';


GlobalKey k1 = GlobalKey();

List<Widget> pages = [
  const Taskspage(),
  const Work_sides(),
  const Reports(),
  const User_preferences()
];

List<BottomNavigationBarItem> Items = [
  BottomNavigationBarItem(
    icon: SvgPicture.asset(Assets.iconsTask , height: 30 ,width: 30 , color: Colors.grey,),
    activeIcon:SvgPicture.asset(Assets.iconsTask , height: 30 ,width: 30 ,  color: Colors.white,),
    label: 'المهام',
  ),

  BottomNavigationBarItem(
      icon: SvgPicture.asset( Assets.iconsHomeWork, height: 30 , color: Colors.grey,),
      activeIcon: SvgPicture.asset( Assets.iconsHomeWork, height: 30 , color: Colors.white,),
      label: 'جهات العمل',
      backgroundColor: Colors.transparent
  ),

  BottomNavigationBarItem(
      icon: SvgPicture.asset( Assets.iconsReport1, height: 30, color: Colors.grey,),
      activeIcon: SvgPicture.asset( Assets.iconsReport1, height: 30 , color: Colors.white,),
      label: 'التقارير',
      backgroundColor: Colors.transparent
  ),

  BottomNavigationBarItem(
      icon: SvgPicture.asset( Assets.iconsUser, height: 30 , color: Colors.grey,),
      activeIcon: SvgPicture.asset( Assets.iconsUser, height: 30 , color: Colors.white,),
      label: 'المستخدم'
  )
];

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {

    return  ShowCaseWidget(
      autoPlay: true,
      builder: (context) {
        return Scaffold(

            appBar: AppBar(  automaticallyImplyLeading: false),

            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: GetBuilder<User>(
              init: User(),
              builder: (controller) {
                return  Visibility(
                  visible: controller.Selectedipage == 2 || controller.Selectedipage == 3 ? false : true,
                  child: Showcase(
                    onTargetClick: () {},
                    description: 'Press to add new tasl',
                    key: k1,
                    descriptionAlignment: TextAlign.center,
                    showArrow: false,
                    disposeOnTap: true,
                    tooltipBorderRadius: BorderRadius.circular(234),
                    targetBorderRadius: BorderRadius.circular(30),
                    disableScaleAnimation: false,
                    tooltipBackgroundColor: Colors.black,
                    textColor: Colors.white,
                    child: FloatingActionButton(
                      onPressed: () async {
                        if(controller.Selectedipage == 0 ){
                          Get.toNamed('/addTask');
                          print(controller.Selectedipage);
                          controller.update();
                        } else if(controller.Selectedipage == 1){
                          print(controller.Selectedipage);
                          Get.toNamed('/addSide');
                        } else{}
                      },
                      backgroundColor: controller.selectedColor,
                      elevation: 10,
                      tooltip: 'اضافة',
                      shape: StadiumBorder(),
                      hoverColor: Colors.lightGreenAccent,
                      splashColor: Colors.transparent,
                      child: SvgPicture.asset(Assets.iconsPlus , color: Colors.white),
                    ),
                  )
                );
              },
            ),



            bottomNavigationBar: GetBuilder<User>(
              init: User(),
              builder: (controller) {
                return SizedBox(
                  height: 70,
                  child: BottomNavigationBar(
                    elevation: 10,
                    onTap: (value) {
                      if(value == 0){
                        controller.openIsBatteryOptimizationDisabledPlugin(context);
                        // ShowCaseWidget.of(context).startShowCase([k1]);
                      } else if(value ==1){
                        NotificationServices().requestPermission(context);
                      }
                      controller.Selectedipage = value;
                      controller.update();
                    },
                    backgroundColor: controller.selectedColor,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                    selectedLabelStyle: const TextStyle(color: Colors.white ,  fontSize: 10 ,fontFamily: 'newfont'),
                    unselectedLabelStyle: const TextStyle(color: Colors.grey , fontSize: 10 ,fontFamily: 'newfont'),
                    useLegacyColorScheme: false,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: controller.Selectedipage,
                    showUnselectedLabels: true,
                    items: Items,
                  ),
                );
              },
            ),


            body: WillPopScope(
                onWillPop: () {
                  return methods.message(context);
                },
                child: GetBuilder<User>(
                  init: User(),
                  builder: (controller) {
                    return pages.elementAt(controller.Selectedipage);
                  },
                )
            )
        );
      },
    );
  }
}


