import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

abstract class DisplayError {
  void showError(BuildContext context, {String errorType="", String message="", bool isSuccess=false});
}

class DisplayImpl extends DisplayError {

  @override
  void showError(BuildContext context, {String errorType="", String message="", bool isSuccess=false}) {

    final Flushbar _flushBar = Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      isDismissible: true,
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
      titleText: Text(
        errorType,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
      ),
      messageText: Text(
        message,
        style: TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
      ),
    );

    _flushBar.show(context);
  }

}