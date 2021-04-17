import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ditto/bloc/home_screen_bloc.dart';
import 'package:ditto/helper/appThemeData.dart';
import 'package:ditto/helper/colors.dart';
import 'package:ditto/helper/enums.dart';
import 'package:ditto/helper/util.dart';
import 'package:ditto/widgets/custom_button.dart';
import 'package:ditto/widgets/leaderboard_widget.dart';
import 'package:ditto/widgets/points_widget.dart';
import 'package:ditto/widgets/progress_bar_widget.dart';
import 'package:ditto/widgets/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  final String logoPath;

  HomeScreen({this.logoPath = 'assets/images/logo.svg'});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeScreenBloc _homeScreenBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _homeScreenBloc = Provider.of<HomeScreenBloc>(context);
    _setTheme();
  }

  void _setTheme(){
    _homeScreenBloc.getPersonalityType().then((value) {
      print(value);
      Provider.of<ThemeNotifier>(context, listen: false).themeNotifier('PersonalityTypes.$value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        //back button remover
        leading: Container(),
        //back button remover end
        title: Container(
          child: SvgPicture.asset(
            widget.logoPath,
            height: 50,
            width: 50,
          ),
        ),
        actions: [
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                Icons.settings,
              ),
            ),
            onTap: () => _homeScreenBloc.navigateToSettings(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30.0),
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.logout),
              ),
              onTap: () => _homeScreenBloc.logout(),
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: Utils.totalBodyHeight,
              child: Padding(
                padding: const EdgeInsets.only(top:30.0, left: 40.0, right: 30.0, bottom:30.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:20.0, left: 20.0, right: 20.0),
                          height:Utils.getDesignHeight(600),
                          width: double.infinity,
                          child: VideoPlayerWidget(
                            videoPath: "https://firebasestorage.googleapis.com/v0/b/ditto-ac673.appspot.com/o/OOPSVideo.mp4?alt=media&token=5f516ffb-8f81-468a-99b9-b2c7fe5aed26",
                            videoType: VideoType.NETWORK,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "OOP Concepts",
                                  style: Theme.of(context).primaryTextTheme.button.copyWith(
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: Utils.getDesignHeight(50),
                                    width: Utils.getDesignWidth(60),
                                    child: CustomButton(
                                      name: 'Rate this Lecture',
                                      borderColor: Theme.of(context).primaryColor,
                                      onTap: () => showDialogBox(),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20.0),
                                    height: Utils.getDesignHeight(50),
                                    width: Utils.getDesignWidth(60),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () => _homeScreenBloc.navigateToTest(),

                                      child: Text(
                                        "Proceed To The Test",
                                        style: Theme.of(context).primaryTextTheme.button.copyWith(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                child: Column(
                  children: [
                    Container(
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
                                child: PointsWidget(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              height: Utils.getDesignHeight(400),
                              child: Card(
                                color: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                child: LeaderBoardWidget(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('student').doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
                            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                              return snapshot.hasData ? Card(
                                color: Theme.of(context).primaryColor,
                                margin: EdgeInsets.all(10.0),
                                child: ProgressBarWidget(
                                  percentage: (snapshot.data.data()['points'] * 2) / 100,
                                  progressColor: Colors.red,
                                  testName: "Lecture 1 Test Progress",
                                ),

                              ): Container();
                            }
                          ),
                          Card(
                            color: Theme.of(context).primaryColor,
                            margin: EdgeInsets.all(10.0),
                            child: ProgressBarWidget(
                              percentage: 0.0,
                              progressColor: Colors.blue,
                              testName: "Pending Lecture Test Progress",
                            ),
                          ),
                          Card(
                            color: Theme.of(context).primaryColor,
                            margin: EdgeInsets.all(10.0),
                            child: ProgressBarWidget(
                              percentage: 0.0,
                              progressColor: Colors.green,
                              testName: "Pending Lecture Test Progress",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showDialogBox() {
    showDialog(
        context: context,
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
            initialRating: 3,
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
            onRatingUpdate: (rating) {
              print(rating);
            },
            ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                height: Utils.getDesignHeight(40),
                width: Utils.getDesignWidth(100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () { },
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
