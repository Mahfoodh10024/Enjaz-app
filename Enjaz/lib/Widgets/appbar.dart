// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/diagnostics.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:tasks/Controller/user_pref.dart';
//
// class MyCustomAppBar extends PreferredSizeWidget {
//   final double preferredHeight; // Adjust height as needed
//
//   MyCustomAppBar(this.preferredHeight);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<User_prefs>( // Use your controller's type
//       builder: (controller) => AppBar(
//         // Use controller.data or other properties here
//         title: Text(''), // Example usage
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(preferredHeight);
//
//   @override
//   String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
//     // Implement logic to return a string representation of your object
//     // You can use super.toString() for base class information
//     return "YourClass(field1: ', field2: ')";
//   }
//
//
//   @override
//   Element createElement() {
//     // TODO: implement createElement
//     throw UnimplementedError();
//   }
//
//   @override
//   List<DiagnosticsNode> debugDescribeChildren() {
//     // TODO: implement debugDescribeChildren
//     throw UnimplementedError();
//   }
//
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     // TODO: implement debugFillProperties
//   }
//
//   @override
//   // TODO: implement key
//   Key? get key => throw UnimplementedError();
//
//   @override
//   DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style}) {
//     // TODO: implement toDiagnosticsNode
//     throw UnimplementedError();
//   }
//
//   @override
//   String toStringDeep({String prefixLineOne = '', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
//     // TODO: implement toStringDeep
//     throw UnimplementedError();
//   }
//
//   @override
//   String toStringShallow({String joiner = ', ', DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
//     // TODO: implement toStringShallow
//     throw UnimplementedError();
//   }
//
//   @override
//   String toStringShort() {
//     // TODO: implement toStringShort
//     throw UnimplementedError();
//   }
// }
