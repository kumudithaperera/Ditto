import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TimeWidget extends StatefulWidget {

  final String uid;

  TimeWidget(this.uid);

  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: Card(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(right: 30.0, left: 30.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('student').doc(widget.uid).snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              return snapshot.hasData ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Time :",
                    style: Theme.of(context).primaryTextTheme.button.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                  ),
                  Text(
                    "${snapshot.data.data()['time']} mins",
                      style: Theme.of(context).primaryTextTheme.button.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )
                  ),
                ],
              ): Container();
            }
          ),
        ),
      ),
    );
  }
}
