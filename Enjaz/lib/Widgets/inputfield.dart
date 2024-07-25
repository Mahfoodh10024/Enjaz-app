import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Field extends StatelessWidget {
   Field({super.key, required this.Read, required this.text, required this.controller, required this.press, required this.title });

  final TextEditingController controller ;
  final bool Read;
  final String text;
  final Widget title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        onTap: () {
          press();
        },
        child: Column(
          children: [
            title,
            Container(
              margin: const EdgeInsets.only(left: 20 , top: 30 , bottom: 30),
              width: 270,
              child: TextFormField(
                controller: controller,
                style: const TextStyle(fontFamily: 'Cairo-medium'),
                readOnly: Read,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: text,
                    hintStyle: const TextStyle(fontSize: 20 , fontFamily: 'Cairo-medium'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
