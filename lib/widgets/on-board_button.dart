import 'package:flutter/material.dart';

class OnBoardButton extends StatelessWidget {
  VoidCallback onpressedfunction;
  String label;
  Color color;

  OnBoardButton(
      {required this.color,
      required this.onpressedfunction,
      required this.label});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      onPressed: onpressedfunction,
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
      ),
    );
  }
}
