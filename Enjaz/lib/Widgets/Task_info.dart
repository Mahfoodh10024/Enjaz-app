import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class inoflistTile extends StatelessWidget {
  const inoflistTile({super.key, required this.text1, required this.colr, required this.Tap, required this.controller});

  final String text1;
  final Color colr;
  final VoidCallback Tap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Tap();
      },
      child: ListTile(
        trailing: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            text1,
            style: const TextStyle(color: Colors.black ,fontSize: 15 , fontWeight: FontWeight.bold),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 20, right: 110),
          child: Container(
              decoration: BoxDecoration(
                color: colr,
                borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              alignment: Alignment.center,
              width: 80,
              height: 60,
              child: TextFormField(
                readOnly: true,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent))
                ),
                controller: controller,
              )
          ),
        ),
      ),
    );
  }
}
