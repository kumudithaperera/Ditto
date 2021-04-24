import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LeaderBoardWidget extends StatefulWidget {

  final bool isIntrovert;
  final String orderBy;
  final String lastKey;

  LeaderBoardWidget({this.isIntrovert, this.orderBy = 'points', this.lastKey = 'points'});

  @override
  _LeaderBoardWidgetState createState() => _LeaderBoardWidgetState();
}

class _LeaderBoardWidgetState extends State<LeaderBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: Card(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('leaderboard').orderBy(widget.orderBy, descending: false).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData ? ListView.builder(
              itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, index){
                  return Card(
                    color: snapshot.data.docs[index].data()['uid'] == FirebaseAuth.instance.currentUser.uid ? Colors.amber : Theme.of(context).backgroundColor,
                    margin: EdgeInsets.all(10.0),
                    child: Container(
                      margin: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${index + 1}",
                            style: Theme.of(context).primaryTextTheme.button.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${snapshot.data.docs[index]['name']}",
                            style: Theme.of(context).primaryTextTheme.button.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          widget.lastKey.contains('points') ? Text(
                            widget.isIntrovert ? "" : "${snapshot.data.docs[index][widget.lastKey]} pts",
                            style: Theme.of(context).primaryTextTheme.button.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ) : Text(
                            "${snapshot.data.docs[index][widget.lastKey]} mins",
                            style: Theme.of(context).primaryTextTheme.button.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              ): Container();
          }
        ),
      ),
    );
  }
}
