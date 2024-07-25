import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.widget, required this.onpress, required this.color});

  final Widget widget;
  final VoidCallback onpress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 60,
      child: ElevatedButton(
        onPressed:() {
          onpress();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(color),
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            elevation: const MaterialStatePropertyAll(1),
            shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))))
        ),
        child: widget,
      ),
    );
  }
}
