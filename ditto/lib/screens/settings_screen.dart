import 'package:ditto/bloc/settings_screen_bloc.dart';
import 'package:ditto/helper/appThemeData.dart';
import 'package:ditto/helper/util.dart';
import 'package:ditto/helper/validation.dart';
import 'package:ditto/widgets/custom_textfield.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  final GlobalKey<FormState> _key = GlobalKey();

  SettingsScreenBloc _settingsScreenBloc;

  String email;

  List<Map<String, dynamic>> _personalityTypeList = [
    {'no': 1, 'keyword': 'INFP'},
    {'no': 2, 'keyword': 'INTJ'},
    {'no': 3, 'keyword': 'INFJ'},
    {'no': 4, 'keyword': 'INTP'},
    {'no': 5, 'keyword': 'ISFJ'},
    {'no': 6, 'keyword': 'ISFP'},
    {'no': 7, 'keyword': 'ISTJ'},
    {'no': 8, 'keyword': 'ISTP'},
    {'no': 9, 'keyword': 'ENFP'},
    {'no': 10, 'keyword': 'ENTJ'},
    {'no': 11, 'keyword': 'ENTP'},
    {'no': 12, 'keyword': 'ENFJ'},
    {'no': 13, 'keyword': 'ESFJ'},
    {'no': 14, 'keyword': 'ESFP'},
    {'no': 15, 'keyword': 'ESTJ'},
    {'no': 16, 'keyword': 'ESTP'}
  ];
  List<DropdownMenuItem> _dropdownTestItems;
  var _selectedTest;

  @override
  void initState() {
    _dropdownTestItems = buildDropdownTestItems(_personalityTypeList);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _settingsScreenBloc = Provider.of<SettingsScreenBloc>(context);
    _settingsScreenBloc.getStudentDetails();
  }

  List<DropdownMenuItem> buildDropdownTestItems(List _testList) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem> items = List();
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  @override
  void dispose() {
    _key.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text("Settings"),
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _settingsScreenBloc.userDetailsStream,
          builder: (context, AsyncSnapshot<UserDetailsModel> snapshot) {
            return snapshot.hasData ? Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Utils.getDesignWidth(100),
                    height: Utils.getDesignHeight(50),
                    child: Text(
                      "${snapshot.data.name}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).primaryTextTheme.button.copyWith(
                       fontWeight: FontWeight.bold,
                       color: Colors.black,
                       fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    width: Utils.getDesignWidth(100),
                    height: Utils.getDesignHeight(50),
                    margin: EdgeInsets.all(5),
                    child: CustomTextField(
                      title: "Email",
                      initialValue: snapshot.data.email,
                      onChange: (email) => this.email = email,
                      validator: (text){
                        if(text.length == 0){
                          return "Please fill this field";
                        }
                        if(!Validation.isValidEmail(text)){
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: Utils.getDesignWidth(100),
                    height: Utils.getDesignHeight(50),
                    margin: EdgeInsets.all(5),
                    child: DropdownBelow(
                      itemWidth: 200,
                      itemTextstyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.pinkAccent),
                      boxTextstyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFFbbbbbb)),
                      boxPadding: EdgeInsets.fromLTRB(13, 12, 0, 12),
                      boxHeight: Utils.getDesignHeight(50),
                      boxWidth: Utils.getDesignWidth(100),
                      hint: Text('${snapshot.data.personalityType}'),
                      value: _selectedTest,
                      items: _dropdownTestItems,
                      onChanged: onChangeDropdownTests,
                    ),
                  ),
                  StreamBuilder(
                  initialData: false,
                  stream: _settingsScreenBloc.pointsLeaderboardStream,
                    builder: (context, snapshot) {
                      return _gameElementsSwitch(
                        text: "Points Leaderboard",
                        value: snapshot.data,
                        onChanged: _settingsScreenBloc.pointsLeaderboardSink.add,
                      );
                    }
                  ),
                  StreamBuilder(
                    initialData: false,
                    stream: _settingsScreenBloc.timeLeaderboardStream,
                    builder: (context, snapshot) {
                      return _gameElementsSwitch(
                        text: "Time Leaderboard",
                        value: snapshot.data,
                        onChanged: _settingsScreenBloc.timeLeaderboardSink.add,
                      );
                    }
                  ),
                  StreamBuilder(
                    initialData: false,
                    stream: _settingsScreenBloc.achievementAndBadgesStream,
                    builder: (context, snapshot) {
                      return _gameElementsSwitch(
                        text: "Achievements and Badges",
                        value: snapshot.data,
                        onChanged: _settingsScreenBloc.achievementAndBadgesSink.add,
                      );
                    }
                  ),
                  StreamBuilder(
                    initialData: false,
                    stream: _settingsScreenBloc.progressBarStream,
                    builder: (context, snapshot) {
                      return _gameElementsSwitch(
                        text: "Progress Bar",
                        value: snapshot.data,
                        onChanged: _settingsScreenBloc.progressBarSink.add,
                      );
                    }
                  ),
                  StreamBuilder(
                    initialData: false,
                    stream: _settingsScreenBloc.pointsStream,
                    builder: (context, snapshot) {
                      return _gameElementsSwitch(
                        text: "Points",
                        value: snapshot.data,
                        onChanged: _settingsScreenBloc.pointsSink.add,
                      );
                    }
                  ),
                  StreamBuilder(
                    initialData: false,
                    stream: _settingsScreenBloc.timeStream,
                    builder: (context, snapshot) {
                      return _gameElementsSwitch(
                        text: "Time",
                        value: snapshot.data,
                        onChanged: _settingsScreenBloc.timeSink.add,
                      );
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: Utils.getDesignHeight(40),
                          width: Utils.getDesignWidth(100),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              if(_key.currentState.validate()){
                                _key.currentState.save();
                                FocusScope.of(context).unfocus();
                                _settingsScreenBloc.updateEmail(
                                  newEmail: email,
                                  personality: _selectedTest != null ? _selectedTest['keyword'] : snapshot.data.personalityType,
                                  isOld: _selectedTest == null ? true : _selectedTest['keyword'][0] == snapshot.data.personalityType[0]
                                );
                              }
                            },
                            child: Text(
                              "Save Details",
                              style: Theme.of(context).primaryTextTheme.button.copyWith(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ) : Container();
          }
        ),
      ),
    );
  }

  Widget _gameElementsSwitch({String text, bool value, Function(bool) onChanged}){
    return Container(
      width: Utils.getDesignWidth(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
          ),
          Switch(
            activeColor: Theme.of(context).primaryColor,
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  onChangeDropdownTests(selectedTest) {
    setState(() {
      _selectedTest = selectedTest;
    });
    Provider.of<ThemeNotifier>(context, listen: false).themeNotifier('PersonalityTypes.${selectedTest['keyword']}');
  }
}
