import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customDialog extends StatelessWidget {
  const customDialog({super.key, required this.message, required this.icon});

  final String message;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          height: 200,
          child: Column(
            children: [
               SizedBox(
                width: 200,
                height: 70,
                child: icon,
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Text(message , style: const TextStyle(fontFamily: 'Cairo-medium' , fontSize: 22)),
              )
            ],
          ),
        ),

        actions: [
          ElevatedButton(
            onPressed: ()=> Navigator.of(context).pop(),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
              elevation: MaterialStatePropertyAll(0),
              overlayColor: MaterialStatePropertyAll(Colors.transparent)
            ),
            child: const Text('إنهاء'),
          )
        ],
      );
  }
}
