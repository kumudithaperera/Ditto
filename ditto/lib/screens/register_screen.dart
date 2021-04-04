import 'package:ditto/bloc/registerBloc.dart';
import 'package:ditto/helper/colors.dart';
import 'package:ditto/helper/enums.dart';
import 'package:ditto/helper/util.dart';
import 'package:ditto/widgets/custom_button.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  List _testList = [{'no': 1, 'keyword': 'blue'},{'no': 2, 'keyword': 'black'},{'no': 3, 'keyword': 'red'}];

  List<Map<String,dynamic>> _personalityTypeList = [
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
  RegisterBloc _registerBloc = RegisterBloc();

  @override
  void initState() {
    _dropdownTestItems = buildDropdownTestItems(_personalityTypeList);
    super.initState();
  }

  List<DropdownMenuItem> buildDropdownTestItems(List _testList) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30.0),
              width: Utils.getDesignWidth(90),
              height: Utils.getDesignHeight(90),
              child: SvgPicture.asset("assets/images/logo.svg"),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Utils.getDesignWidth(100),
                      height: Utils.getDesignHeight(50),
                      margin: EdgeInsets.all(5),
                      child: TextField(
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          labelText: 'Name',
                          fillColor: PrimaryColorBasic,
                        ),
                      ),
                    ),
                    Container(
                      width: Utils.getDesignWidth(100),
                      height: Utils.getDesignHeight(50),
                      margin: EdgeInsets.all(5),
                      child:

                      // new DropdownButton<String>(
                      //   isExpanded: true,
                      //   hint: Text("Personality Type"),
                      //   items: _personalityTypeList.map((String value) {
                      //     return new DropdownMenuItem<String>(
                      //       value: value,
                      //       child: new Text(value),
                      //     );
                      //   }).toList(),
                      //   onChanged: (_) {},
                      // ),

                      DropdownBelow(
                        itemWidth: 200,
                        itemTextstyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                        boxTextstyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0XFFbbbbbb)),
                        boxPadding: EdgeInsets.fromLTRB(13, 12, 0, 12),
                        boxHeight: Utils.getDesignHeight(50),
                        boxWidth: Utils.getDesignWidth(100),
                        hint: Text('Choose Your Personality'),
                        value: _selectedTest,
                        items: _dropdownTestItems,
                        onChanged: onChangeDropdownTests,
                      ),

                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Do the personality test "),
                        TextSpan(
                            style: TextStyle(color: Colors.blue, decoration:TextDecoration.underline),
                            text: "Click here",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                var url =
                                    "https://www.16personalities.com/free-personality-test";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                      ]),
                    ),
                    Container(
                      width: Utils.getDesignWidth(100),
                      height: Utils.getDesignHeight(50),
                      margin: EdgeInsets.all(5),
                      child: TextField(
                        decoration: InputDecoration(
                          focusColor: PrimaryColorBasic,
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      width: Utils.getDesignWidth(100),
                      height: Utils.getDesignHeight(50),
                      margin: EdgeInsets.all(5),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          focusColor: PrimaryColorBasic,
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      width: Utils.getDesignWidth(50),
                      height: Utils.getDesignHeight(30),
                      margin: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: PrimaryColorBasic
                        ),
                        onPressed: () {
                          _registerBloc.personalityTypeSink.add(PersonalityTypes.ENFJ);
                          Navigator.pushNamed(context, '/home');
                        },
                        child: Text(
                          "Register",
                          style: Theme.of(context).primaryTextTheme.button.copyWith(
                                fontSize: 15,
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: CustomButton(
                        name: 'Login',
                        borderColor: PrimaryColorBasic,
                        onTap: () => Navigator.pushNamed(context, '/login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest = selectedTest;
    });
  }

  // _launchURL() async {
  //   const url = '';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
