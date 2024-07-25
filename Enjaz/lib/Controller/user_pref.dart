//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iglu_color_picker_flutter/widgets/hue_ring_picker.dart';
//
// import '../Views/dope.dart';
//
// class User_prefs extends GetxController{
//
//    @override
//   void onReady() {
//     // TODO: implement onReady
//     super.onReady();
//     update();
//   }
//
//
//   Color selectedColor = const Color(0xff3600b2);
//
//   //loadDefaultColor from SharedPreferences
//   void _loadDefaultColor() async {
//     final savedColor = shared.getInt('defaultColor');
//     if (savedColor != null) {
//        selectedColor = Color(savedColor);
//     }
//     print(selectedColor);
//   }
//
//
//
//
//   //Save user color
//   void _saveDefaultColor() async {
//     shared.setInt('defaultColor' , selectedColor.value);
//     print('save');
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     update();
//     _loadDefaultColor();
//   }
//
//
//
//
//   pickColor(BuildContext context){
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         content: Container(
//           width: 500,
//           height: 450,
//           alignment: Alignment.center,
//           child: IGHueRingPicker(
//             currentColor: selectedColor,
//             inputBarBorderColor: Colors.transparent,
//             alphaSliderBorderColor: Colors.transparent,
//             areaRadius: 20,
//             hueRingBorderWidth: 0,
//             alphaSliderBorderWidth: 0,
//             alphaSliderRadius: 5,
//             areaBorderColor: Colors.transparent,
//             areaBorderWidth: 5,
//             onColorChanged: (color) {
//               selectedColor = color;
//               update();
//             },
//           ),
//         ),
//
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               _saveDefaultColor();
//               Navigator.pop(context);
//             },
//             child: const Text('Save'),
//           ),
//         ],
//
//       ),
//     );
//   }
//
// }