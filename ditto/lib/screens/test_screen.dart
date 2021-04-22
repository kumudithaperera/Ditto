import 'package:ditto/bloc/test_bloc.dart';
import 'package:ditto/helper/enums.dart';
import 'package:ditto/helper/util.dart';
import 'package:ditto/widgets/achivement_widget.dart';
import 'package:ditto/widgets/count_down.dart';
import 'package:ditto/widgets/leaderboard_widget.dart';
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
                  builder: (context, AsyncSnapshot<GamificationElementType> snapshot) {
                    return Column(
                      children: [
                        Container(
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
                                      isIntrovert: snapshot.data == GamificationElementType.E ? false : true,
                                      lastKey: 'time',
                                      orderBy: 'time',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        snapshot.data == GamificationElementType.E ? Container() : StreamBuilder<bool>(
                          stream: _testBloc.marksBadgeStream,
                          builder: (context, snapshot) {
                            return snapshot.hasData && snapshot.data ? Container(
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
                                          imagePath: "assets/images/achivement.svg",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ): Container();
                          }
                        ),
                        snapshot.data == GamificationElementType.E ? Container() : StreamBuilder<bool>(
                          stream: _testBloc.timeBadgeStream,
                          builder: (context, snapshot) {
                            return snapshot.hasData && snapshot.data ? Container(
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
                                          title: "Finished Test Before 08 mins",
                                          imagePath: "assets/images/achivement.svg",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ): Container();
                          }
                        ),
                      ],
                    );
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
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ditto/bloc/home_screen_bloc.dart';
// import 'package:ditto/bloc/sign_in_sign_up_bloc.dart';
// import 'package:ditto/helper/appThemeData.dart';
// import 'package:ditto/helper/colors.dart';
// import 'package:ditto/helper/enums.dart';
// import 'package:ditto/helper/util.dart';
// import 'package:ditto/widgets/achivement_widget.dart';
// import 'package:ditto/widgets/custom_button.dart';
// import 'package:ditto/widgets/leaderboard_widget.dart';
// import 'package:ditto/widgets/points_widget.dart';
// import 'package:ditto/widgets/progress_bar_widget.dart';
// import 'package:ditto/widgets/video_player.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
//
// class HomeScreen extends StatefulWidget {
//
//   final String logoPath;
//
//   HomeScreen({this.logoPath = 'assets/images/logo.svg'});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   HomeScreenBloc _homeScreenBloc;
//   SignInSignUpBloc _signInSignUpBloc;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     _homeScreenBloc = Provider.of<HomeScreenBloc>(context);
//     _signInSignUpBloc = Provider.of<SignInSignUpBloc>(context);
//     _homeScreenBloc.getStudentDetails();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).backgroundColor,
//       appBar: AppBar(
//         //back button remover
//         leading: Container(),
//         //back button remover end
//         title: Container(
//           child: SvgPicture.asset(
//             widget.logoPath,
//             height: 50,
//             width: 50,
//           ),
//         ),
//         actions: [
//           InkWell(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: Icon(
//                 Icons.settings,
//               ),
//             ),
//             onTap: () => _homeScreenBloc.navigateToSettings(),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 30.0, left: 30.0),
//             child: InkWell(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Icon(Icons.logout),
//               ),
//               onTap: () => _signInSignUpBloc.logout(),
//             ),
//           ),
//         ],
//       ),
//       body: StreamBuilder(
//           stream: _homeScreenBloc.elementTypeStream,
//           builder: (context, AsyncSnapshot<GamificationElementType> snapshot) {
//             return snapshot.hasData ?  : Container();
//           }
//       ),
//     );
//   }
//
//   showDialogBox() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               margin: EdgeInsets.only(bottom: 20.0),
//               child: Text('How motivated are you to continue',
//                 style: Theme.of(context).primaryTextTheme.button.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             RatingBar.builder(
//               initialRating: 0,
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 switch (index) {
//                   case 0:
//                     return Icon(
//                       Icons.sentiment_very_dissatisfied,
//                       color: Colors.red,
//                     );
//                   case 1:
//                     return Icon(
//                       Icons.sentiment_dissatisfied,
//                       color: Colors.redAccent,
//                     );
//                   case 2:
//                     return Icon(
//                       Icons.sentiment_neutral,
//                       color: Colors.amber,
//                     );
//                   case 3:
//                     return Icon(
//                       Icons.sentiment_satisfied,
//                       color: Colors.lightGreen,
//                     );
//                   case 4:
//                     return Icon(
//                       Icons.sentiment_very_satisfied,
//                       color: Colors.green,
//                     );
//                   default:
//                     return Icon(
//                       Icons.sentiment_very_satisfied,
//                       color: Colors.green,
//                     );
//                 }
//               },
//               onRatingUpdate: (rating) => _homeScreenBloc.ratingSink.add(rating.toInt()),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 30.0),
//               height: Utils.getDesignHeight(40),
//               width: Utils.getDesignWidth(100),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary: Theme.of(context).primaryColor,
//                 ),
//                 onPressed: () => _homeScreenBloc.updaterRate(),
//                 child: Text(
//                   "Rate the Lecture",
//                   style: Theme.of(context).primaryTextTheme.button.copyWith(
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
