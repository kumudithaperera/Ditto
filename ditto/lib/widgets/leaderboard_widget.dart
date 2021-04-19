import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderBoardWidget extends StatefulWidget {

  final bool isIntrovert;

  LeaderBoardWidget({this.isIntrovert});

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
          stream: FirebaseFirestore.instance.collection('leaderboard').orderBy('points', descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData ? ListView.builder(
              itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, index){
                  return Card(
                    color: Theme.of(context).backgroundColor,
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
                          Text(
                            widget.isIntrovert ? "" : "${snapshot.data.docs[index]['points']} pts",
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
