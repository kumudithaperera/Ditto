import 'package:ditto/helper/colors.dart';
import 'package:ditto/helper/util.dart';
import 'package:ditto/widgets/custom_button.dart';
import 'package:ditto/widgets/leaderboard_widget.dart';
import 'package:ditto/widgets/points_widget.dart';
import 'package:ditto/widgets/progress_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {

  final String logoPath;

  HomeScreen({this.logoPath = 'assets/images/logo.svg'});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30.0),
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.logout),
              ),
              onTap: () {},
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
                          color: Colors.blue
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Lecture Title",
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
                                      onTap: () {},
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
                                      onPressed: () {},

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
                          Card(
                            color: Theme.of(context).primaryColor,
                            margin: EdgeInsets.all(10.0),
                            child: ProgressBarWidget(
                              percentage: 0.9,
                              progressColor: Colors.red,
                              testName: "Lecture 1 Test Progress",
                            ),

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
}
