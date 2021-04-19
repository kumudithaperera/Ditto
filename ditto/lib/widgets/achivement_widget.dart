import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ditto/helper/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AchievementWidget extends StatefulWidget {
  @override
  _AchievementWidgetState createState() => _AchievementWidgetState();
}

class _AchievementWidgetState extends State<AchievementWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: Card(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(right: 30.0, left: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: SvgPicture.asset("assets/images/achivement.svg",
                  width: Utils.getDesignWidth(70),
                  height: Utils.getDesignHeight(70),
                ),
              ),
              Flexible(
                child: Text(
                    "Test 1 Passed",
                    style: Theme.of(context).primaryTextTheme.button.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
