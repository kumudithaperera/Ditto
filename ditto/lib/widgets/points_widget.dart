import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PointsWidget extends StatefulWidget {

  final String uid;

  PointsWidget(this.uid);

  @override
  _PointsWidgetState createState() => _PointsWidgetState();
}

class _PointsWidgetState extends State<PointsWidget> {
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
                    "Points :",
                    style: Theme.of(context).primaryTextTheme.button.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                  ),
                  Text(
                    "${snapshot.data.data()['points']}",
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
