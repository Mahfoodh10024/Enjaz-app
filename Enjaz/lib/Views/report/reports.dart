import 'package:flutter/material.dart';
import 'package:tasks/Views/report/tab1.dart';
import 'package:tasks/Views/report/tab2.dart';
import 'package:tasks/Views/report/tasks_an.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}


class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          automaticallyImplyLeading: false ,
          bottom: const TabBar(
          tabs: [
            Tab(child: Text('المهام')),
            // Tab(child: Text('المنجز')),
            Tab(child: Text('المحذوف'))
          ],
        ),
        ),

        body: Container(
          padding: const EdgeInsets.all(10),
          child: const TabBarView(
            children: [
              Task_an(),
              // Tab1(),
              Tab2()
            ],
          ),
        )
      ),
    );
  }
}

