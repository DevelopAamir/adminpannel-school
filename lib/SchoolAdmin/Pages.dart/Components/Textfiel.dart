import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final String text;
  final IconData icon;
  final obsecuewtext;
  final controller;
  final onChange;
  final onTap;

  const Textfield({
    Key? key,
    required this.text,
    required this.obsecuewtext,
    required this.icon,
    required this.controller,
    required this.onChange,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          keyboardType: TextInputType.text,
          onTap: onTap,
          onChanged: onChange,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: (Icon(
              icon,
              // color: Color(0xff12B081),
            )),
            labelText: text,
            hintText: text,
          ),
        ),
      ),
    );
  }
}
 