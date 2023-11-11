
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final List<Color> predefinedColors = [
  Color(0xffd2a7d3),
  Color(0xffFF9E9E),
  Color(0xffd3af1f),
  Color(0xffda5e7a),
  Color(0xffa2ea9f),
  Color(0xff805de1),
  Color(0xff3df5f5),
];

void toast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orangeAccent,
      textColor: Colors.white70,
      fontSize: 16.0);
}