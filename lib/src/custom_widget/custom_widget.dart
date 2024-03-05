import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomWidget {
  static void toast(text, color) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}