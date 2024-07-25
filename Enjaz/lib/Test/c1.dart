// ignore_for_file: unused_local_variable, await_only_futures, avoid_print

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_ignorebatteryoptimization/flutter_ignorebatteryoptimization.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  final _flutterIgnorebatteryoptimizationPlugin = FlutterIgnorebatteryoptimization();

  @override
  void initState() {
    super.initState();
  }

  Future<void>  openIgnorebatteryoptimizationPlugin() async {
    String ignoreBatteryOptimization;
    try {
      ignoreBatteryOptimization = await _flutterIgnorebatteryoptimizationPlugin.showIgnoreBatteryOptimizationSettings() ??
          'Unknown ignoreBatteryOptimization';
    } on PlatformException {
      ignoreBatteryOptimization = 'Failed to show ignoreBatteryOptimization.';
    }
  }

  Future<void> openIsBatteryOptimizationDisabledPlugin() async {
    String? isBatteryOptimizationDisabled;
    //print("isBatteryOptimizationDisabled: $isBatteryOptimizationDisabled");
    try {
      isBatteryOptimizationDisabled = await _flutterIgnorebatteryoptimizationPlugin.isBatteryOptimizationDisabled() == true ? "Disabled" : "Enabled";
      print("isBatteryOptimizationDisabled: $isBatteryOptimizationDisabled");

      // Disabled ==> means you have set no restrictions
      // Enabled ==> means you have not set no restrictions

    } on PlatformException {
      isBatteryOptimizationDisabled =
      'Failed to show ignoreBatteryOptimization.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter IgnoreBatteryOptimization'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //
              ElevatedButton(
                onPressed: () {
                  openIgnorebatteryoptimizationPlugin();
                },
                child: const Text(
                    "Request ignore-battery-optimization permission"),
              ),
              //
              ElevatedButton(
                onPressed: () {
                  openIsBatteryOptimizationDisabledPlugin();
                },
                child: const Text("is ignore-battery-optimization disabled"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}