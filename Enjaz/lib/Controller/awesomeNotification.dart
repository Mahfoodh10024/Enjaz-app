import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:tasks/Views/Taskinfo.dart';
import 'package:tasks/Views/add_activity.dart';
import 'package:tasks/Views/work_sides.dart';
import 'package:tasks/main.dart';

import '../Views/tasks.dart';

class NotificationServices {

  requestPermission(BuildContext context){
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            title: const Text('السماح بالاشعارات', style: TextStyle(fontSize: 20)),
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('بتطلب التطبيق إذن إرسال الاشعارات'),
              ],
            ),
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Column(
                children: [
                  SizedBox(
                    width: 170,
                    height: 40,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0),
                          backgroundColor: MaterialStatePropertyAll(Color(0xff4fa84f)),
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ))
                      ),
                      child: const Text("تمكين",
                          style: TextStyle(color: Colors.white , fontSize: 15 )
                      ),
                      onPressed: () => AwesomeNotifications().requestPermissionToSendNotifications().then((_) => Navigator.pop(context)),


                    ),
                  ),

                  const Divider(color: Colors.transparent),
                  SizedBox(
                    width: 170,
                    height: 40,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0),
                          backgroundColor: MaterialStatePropertyAll(Color(0xffede7f3)),
                          overlayColor: MaterialStatePropertyAll(Colors.transparent),
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ))
                      ),
                      child: const Text("غير موافق",
                          style: TextStyle(color: Colors.black , fontSize: 15 )
                      ),
                      onPressed: () => Navigator.pop(context),

                    ),
                  ),
                ],
              )
            ],
          ),
        );

      }
    },
    );
  }




  static Future<void> initializeNotification() async {
    print('Notification initialized');
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'scheduled',
          channelKey: 'scheduling',
          channelName: 'scheduling notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        ),
        NotificationChannel(
          channelGroupKey: 'timed',
          channelKey: 'timed',
          channelName: 'Timed notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        )
      ],
      debug: true,
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }


  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
      debugPrint('onNotificationDisplayedMethod');
  }



  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};
    if (payload["period"] == "true") {
      Get.to(Work_sides());
      print('in');
    }
    Get.to(Main());
  }


  static Future schedulingMinutes({
    required String title,
    required String body,
    required int time,
    required int id,
    final Map<String, String>? payload,
  })async{

     await AwesomeNotifications().createNotification(
          schedule: NotificationInterval(
              interval: time,
              repeats: true ,
              timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier()
          ),
          content: NotificationContent(
            id: id,
            channelKey: 'scheduling',
            title: title,
            body: body,
            payload: {'period':'true'},
            backgroundColor: Colors.white,
            color: Colors.black,
            displayOnBackground: true,
            displayOnForeground: true,
          )
      );
     print('object');
  }


  static Future timed({
    required String title,
    required String body,
    required DateTime time,
    final Map<String, String>? payload,
  })async{
    await AwesomeNotifications().createNotification(
        schedule: NotificationAndroidCrontab.hourly(referenceDateTime: time),
        content: NotificationContent(
          id: 2,
          channelKey: 'timed',
          title: title,
          body: body,
          payload: payload,
          backgroundColor: Colors.white,
          color: Colors.black,
          displayOnBackground: true,
          displayOnForeground: true,
        )
    );
  }



  static Future Alert({
    required String title,
    required String body,
    required int year,
    required int month,
    required int day,
    final Map<String, String>? payload,
  })async{

    await AwesomeNotifications().createNotification(
        schedule: NotificationCalendar(
          year: year,
          month: month,
          day: day,
        ),
        content: NotificationContent(
          id: 1,
          channelKey: 'scheduling',
          title: title,
          body: body,
          payload: payload,
          fullScreenIntent: true,
          backgroundColor: Colors.white,
          color: Colors.black,
          displayOnBackground: true,
          displayOnForeground: true
        )
    );
  }


  // wm(){
  //   print('Wom');
  //   Workmanager().registerOneOffTask(
  //     'send_notification_1',
  //     'send_notification',
  //     inputData: {'id': 1, 'title': 'Notification 1', 'body': 'This is the first notification'},
  //     initialDelay: const Duration(seconds: 5),
  //   );
  //
  //   Workmanager().registerPeriodicTask(
  //     'send_notification_2',
  //     'send_notification',
  //     inputData: {'id': 2, 'title': 'Notification 2', 'body': 'This is the second notification'},
  //     frequency: const Duration(minutes: 15),
  //     // constraints: Constraints(
  //     //   networkType: NetworkType.connected,
  //     //   requiresBatteryNotLow: true
  //     // ),
  //   );
  //
  // }


  static Future cancel(int id){
   return AwesomeNotifications().cancelSchedule(id);
  }

 static List<String> titles =[
    'title','title1','title2'
  ];

}


