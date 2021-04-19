import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBarWidget extends StatefulWidget {

  final String testName;
  final double percentage;
  final Color progressColor;

  ProgressBarWidget({this.testName, this.percentage, this.progressColor});

  @override
  _ProgressBarWidgetState createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(7.0),
        color: Theme.of(context).backgroundColor,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            percent: (widget.percentage),
            header: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(widget.testName),
            ),
            center: Icon(
              Icons.person_pin,
              size: 50.0,
              color: widget.progressColor,
            ),
            backgroundColor: Colors.grey,
            progressColor: widget.progressColor,
          ),
        ),
      ),
    );
  }
}
