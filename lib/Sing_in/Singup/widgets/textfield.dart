import 'package:flutter/material.dart';

class GateFormField extends StatelessWidget {
  String hint;
  Widget icon;
  TextEditingController formcontroller;

  GateFormField(
      {required this.hint, required this.icon, required this.formcontroller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
          cursorColor: Colors.grey,
          controller: formcontroller,
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            prefixIcon: icon,
            prefixIconColor: Colors.grey,
            focusColor: null,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          )),
    );
  }
}
