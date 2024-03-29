import 'package:ditto/bloc/test_bloc.dart';
import 'package:ditto/helper/app_data.dart';
import 'package:ditto/helper/enums.dart';
import 'package:ditto/helper/util.dart';
import 'package:ditto/widgets/achivement_widget.dart';
import 'package:ditto/widgets/count_down.dart';
import 'package:ditto/widgets/leaderboard_widget.dart';
import 'package:ditto/widgets/time_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> with SingleTickerProviderStateMixin {

  final _contentVariables = ContentVariables.getInstance;

  TestBloc _testBloc;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(minutes: 5), vsync: this);
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
        _testBloc.savePoint(10);
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: Utils.getDesignWidth(20)),
                child: Column(
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
                              begin: 5 * 60,
                              end: 0,
                            ).animate(_controller),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: StreamBuilder<int>(
                          stream: _testBloc.questionOneStream,
                          builder: (context, snapshot) {
                            return _questionAndAnswer(
                              question: '1. What is Inheritance?',
                              answerOne: 'nothing but assigning behavior or value in a subclass to something that was already declared in the main class',
                              answerTwo: 'concept where one class shares the structure and behavior defined in another class.',
                              answerVal: snapshot.data,
                              sink: _testBloc.questionOneSink,
                            );
                          }
                      ),
                    ),
                    Center(
                      child: StreamBuilder<int>(
                          stream: _testBloc.questionTwoStream,
                          builder: (context, snapshot) {
                            return _questionAndAnswer(
                              question: '2. What is an abstract class?',
                              answerOne: 'class which cannot be instantiated',
                              answerTwo: ' an instance of a class',
                              answerVal: snapshot.data,
                              sink: _testBloc.questionTwoSink,
                            );
                          }
                      ),
                    ),
                    Center(
                      child: StreamBuilder<int>(
                          stream: _testBloc.questionThreeStream,
                          builder: (context, snapshot) {
                            return _questionAndAnswer(
                              question: '3. What is abstraction?',
                              answerOne: 'shows only the necessary details to the client of an object.',
                              answerTwo: 'simply a representation of a type of object.',
                              answerVal: snapshot.data,
                              sink: _testBloc.questionThreeSink,
                            );
                          }
                      ),
                    ),
                    Center(
                      child: StreamBuilder<int>(
                          stream: _testBloc.questionFourStream,
                          builder: (context, snapshot) {
                            return _questionAndAnswer(
                              question: '4. What is Polymorphism?',
                              answerOne: 'concept where one class shares the structure and behavior defined in another class.',
                              answerTwo: ' nothing but assigning behavior or value in a subclass to something that was already declared in the main class.',
                              answerVal: snapshot.data,
                              sink: _testBloc.questionFourSink,
                            );
                          }
                      ),
                    ),
                    Center(
                      child: StreamBuilder<int>(
                          stream: _testBloc.questionFiveStream,
                          builder: (context, snapshot) {
                            return _questionAndAnswer(
                              question: '5. What is an interface?',
                              answerOne: 'collection of an abstract method.',
                              answerTwo: 'it shows only the necessary details to the client of an object.',
                              answerVal: snapshot.data,
                              sink: _testBloc.questionFiveSink,
                            );
                          }
                      ),
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
                            _testBloc.savePoint(_controller.lastElapsedDuration.inSeconds);
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
          Expanded(
            flex: 1,
            child: Container(
              height: Utils.totalBodyHeight,
              padding: EdgeInsets.symmetric(horizontal: Utils.getDesignWidth(5)),
              child: SingleChildScrollView(
                child: StreamBuilder(
                  stream: _testBloc.elementTypeStream,
                  builder: (context, snapshot) {
                    return snapshot.hasData ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _contentVariables.time ? Container(
                          margin: EdgeInsets.only(top: 30.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  height: Utils.getDesignHeight(100),
                                  child: Card(
                                    color: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: TimeWidget(FirebaseAuth.instance.currentUser.uid),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) : Container(),
                        _contentVariables.timeLeaderboard ? Container(
                          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  height: Utils.getDesignHeight(300),
                                  child: Card(
                                    color: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: LeaderBoardWidget(
                                      isIntrovert: _contentVariables.time ? true : false,
                                      lastKey: 'time',
                                      orderBy: 'time',
                                      descending: false,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) : Container(),
                        _contentVariables.achievementsBadges ? Padding(
                          padding: EdgeInsets.only(left: Utils.getDesignWidth(1.0)),
                          child: Text(
                              "Achievements & Badges",
                              style: Theme.of(context).primaryTextTheme.button.copyWith(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                          ),
                        ): Container(),
                        _contentVariables.timeLeaderboard ? StreamBuilder<bool>(
                            initialData: false,
                            stream: _testBloc.marksBadgeStream,
                            builder: (context, snapshot) {
                              return Container(
                                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: Utils.getDesignHeight(100),
                                        child: Card(
                                          color: Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: AchievementWidget(
                                            title: "Above 40 marks",
                                            imagePath: "assets/images/morePointsBadge.svg",
                                            isDone: snapshot.data,
                                            lock: "assets/images/lock.svg",
                                            width: 45,
                                            height: 45,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                        ) : Container(),
                        _contentVariables.achievementsBadges ? StreamBuilder<bool>(
                            initialData: false,
                            stream: _testBloc.timeBadgeStream,
                            builder: (context, snapshot) {
                              return Container(
                                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: Utils.getDesignHeight(100),
                                        child: Card(
                                          color: Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: AchievementWidget(
                                            title: "Finished Test Before 01 mins",
                                            imagePath: "assets/images/TimeAchievementBadge.svg",
                                            isDone: snapshot.data,
                                            lock: "assets/images/lock.svg",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                        ): Container(),
                      ],
                    ): Container();
                  }
                ),
              ),
            ),
          ),
        ],
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
              child: Text('How would you rate the game elements in Test Page',
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
                  "Rate the Game Elements",
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