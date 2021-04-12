import 'package:flutter/material.dart';

class PointsWidget extends StatefulWidget {
  @override
  _PointsWidgetState createState() => _PointsWidgetState();
}

class _PointsWidgetState extends State<PointsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Card(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(right: 30.0, left: 30.0),
          child: Row(
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
                "0",
                  style: Theme.of(context).primaryTextTheme.button.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
