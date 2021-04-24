import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ditto/helper/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AchievementWidget extends StatefulWidget {

  final String imagePath;
  final String lock;
  final String title;
  final bool isDone;

  AchievementWidget({this.imagePath, this.title, this.lock, this.isDone});

  @override
  _AchievementWidgetState createState() => _AchievementWidgetState();
}

class _AchievementWidgetState extends State<AchievementWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: Utils.getDesignHeight(100),
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
          child: Card(
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: SvgPicture.asset(widget.imagePath,
                      width: Utils.getDesignWidth(70),
                      height: Utils.getDesignHeight(70),
                    ),
                  ),
                  Flexible(
                    child: Text(
                        widget.title,
                        style: Theme.of(context).primaryTextTheme.button.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        !widget.isDone ? Container(
          width: double.infinity,
          height: double.infinity,
          child: Card(
            color: Colors.grey.withOpacity(0.5),
            child: Icon(Icons.lock, color: Colors.black, size: 40,),
          ),
        ): Container(),
      ],
    );
  }
}
