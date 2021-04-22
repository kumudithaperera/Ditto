import 'package:ditto/bloc/test_bloc.dart';
import 'package:ditto/helper/util.dart';
import 'package:ditto/widgets/count_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> with SingleTickerProviderStateMixin {

  TestBloc _testBloc;

  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(minutes: 10), vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _testBloc = Provider.of<TestBloc>(context);
    _testBloc.getStudentDetails();

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed){
        _testBloc.savePoint();
        showDialogBox(isDismissible: false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text("Logic Gates Test"),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: Utils.getDesignHeight(800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Utils.getDesignHeight(30.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Time Left: ",
                        style: Theme.of(context).primaryTextTheme.button.copyWith(
                          fontSize: 40,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      CountDown(
                        animation: StepTween(
                          begin: 10 * 60,
                          end: 0,
                        ).animate(_controller),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<int>(
                  stream: _testBloc.questionOneStream,
                  builder: (context, snapshot) {
                    return _questionAndAnswer(
                      question: '1. What is Inheritance?',
                      answerOne: 'nothing but assigning behavior or value in a subclass to something that was already declared in the main class',
                      answerTwo: 'concept where one class shares the structure and behavior defined in another class.*',
                      answerVal: snapshot.data,
                      sink: _testBloc.questionOneSink,
                    );
                  }
                ),
                StreamBuilder<int>(
                    stream: _testBloc.questionTwoStream,
                  builder: (context, snapshot) {
                    return _questionAndAnswer(
                      question: '2. What is an abstract class?',
                      answerOne: 'class which cannot be instantiated*',
                      answerTwo: ' an instance of a class',
                      answerVal: snapshot.data,
                      sink: _testBloc.questionTwoSink,
                    );
                  }
                ),
                StreamBuilder<int>(
                    stream: _testBloc.questionThreeStream,
                  builder: (context, snapshot) {
                    return _questionAndAnswer(
                      question: '3. What is abstraction?',
                      answerOne: 'shows only the necessary details to the client of an object.*',
                      answerTwo: 'simply a representation of a type of object.',
                      answerVal: snapshot.data,
                      sink: _testBloc.questionThreeSink,
                    );
                  }
                ),
                StreamBuilder<int>(
                    stream: _testBloc.questionFourStream,
                  builder: (context, snapshot) {
                    return _questionAndAnswer(
                      question: '4. What is Polymorphism?',
                      answerOne: 'concept where one class shares the structure and behavior defined in another class.',
                      answerTwo: ' nothing but assigning behavior or value in a subclass to something that was already declared in the main class.*',
                      answerVal: snapshot.data,
                      sink: _testBloc.questionFourSink,
                    );
                  }
                ),
                StreamBuilder<int>(
                    stream: _testBloc.questionFiveStream,
                  builder: (context, snapshot) {
                    return _questionAndAnswer(
                      question: '5. What is an interface?',
                      answerOne: 'collection of an abstract method.*',
                      answerTwo: 'it shows only the necessary details to the client of an object.',
                      answerVal: snapshot.data,
                      sink: _testBloc.questionFiveSink,
                    );
                  }
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20.0),
                    height: Utils.getDesignHeight(40),
                    width: Utils.getDesignWidth(100),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        _testBloc.savePoint();
                        showDialogBox();
                      },
                      child: Text(
                        "Submit Answers",
                        style: Theme.of(context).primaryTextTheme.button.copyWith(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _questionAndAnswer({String question, String answerOne, String answerTwo, int answerVal, Sink<int> sink}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15.0),
          child: Text(
            question,
            style: Theme.of(context).primaryTextTheme.button.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              RadioListTile(
                title: Text(answerOne),
                value: 1,
                groupValue: answerVal,
                onChanged: (value) => sink.add(value),
              ),
              RadioListTile(
                title: Text(answerTwo),
                value: 2,
                groupValue: answerVal,
                onChanged: (value) => sink.add(value),
              ),
            ],
          ),
        ),
      ],
    );
  }

  showDialogBox({bool isDismissible = true}) {
    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Text('How motivated are you to continue',
                style: Theme.of(context).primaryTextTheme.button.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: 0,
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                    );
                  case 1:
                    return Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.redAccent,
                    );
                  case 2:
                    return Icon(
                      Icons.sentiment_neutral,
                      color: Colors.amber,
                    );
                  case 3:
                    return Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.lightGreen,
                    );
                  case 4:
                    return Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                    );
                  default:
                    return Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                    );
                }
              },
              onRatingUpdate: (rating) => _testBloc.ratingSink.add(rating.toInt()),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              height: Utils.getDesignHeight(40),
              width: Utils.getDesignWidth(100),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                onPressed: () => _testBloc.updaterRate(),
                child: Text(
                  "Rate the Lecture",
                  style: Theme.of(context).primaryTextTheme.button.copyWith(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
