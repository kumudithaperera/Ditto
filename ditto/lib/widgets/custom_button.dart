import 'package:ditto/helper/util.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  CustomButton({this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: Utils.getDesignWidth(50),
        height: Utils.getDesignHeight(30),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(
              width: 2.0,
              color: Colors.orange,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: Text(
            name,
            style: Theme.of(context).primaryTextTheme.button.copyWith(
                  fontSize: 15,
                ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
