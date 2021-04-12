import 'package:flutter/material.dart';

class LeaderBoardWidget extends StatefulWidget {
  @override
  _LeaderBoardWidgetState createState() => _LeaderBoardWidgetState();
}

class _LeaderBoardWidgetState extends State<LeaderBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Card(
        child: ListView.builder(
          itemCount: 10,
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
                        "$index",
                        style: Theme.of(context).primaryTextTheme.button.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "$index",
                        style: Theme.of(context).primaryTextTheme.button.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "$index",
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
            }),
      ),
    );
  }
}
