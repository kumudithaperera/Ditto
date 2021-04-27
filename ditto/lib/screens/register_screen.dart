import 'package:ditto/bloc/sign_in_sign_up_bloc.dart';
import 'package:ditto/helper/appThemeData.dart';
import 'package:ditto/helper/enums.dart';
import 'package:ditto/helper/util.dart';
import 'package:ditto/helper/validation.dart';
import 'package:ditto/widgets/custom_button.dart';
import 'package:ditto/widgets/custom_textfield.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


SharedPreferences preferences;

class RegisterScreen extends StatefulWidget {

  final String logoPath;
  final String imagePath;

  RegisterScreen({this.logoPath = 'assets/images/logo.svg', this.imagePath = ''});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

int colorCodeNumber = 0;

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<FormState> _key = GlobalKey();

  String email, password, name, personality;

  SignInSignUpBloc _signInSignUpBloc;

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

    _signInSignUpBloc = Provider.of<SignInSignUpBloc>(context);
  }

  @override
  void dispose() {
    _key.currentState?.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Form(
          key: _key,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Utils.getDesignWidth(100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.imagePath != '' ? Image.asset(
                      widget.imagePath,
                    ): Container(),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30.0),
                    width: Utils.getDesignWidth(90),
                    height: Utils.getDesignHeight(90),
                    child: SvgPicture.asset(widget.logoPath),
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
                            child: CustomTextField(
                              title: "Name",
                              onChange: (name) => this.name = name,
                              validator: (text){
                                if(text.length == 0){
                                  return "Please fill this field";
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
                              hint: Text('Choose Your Personality'),
                              value: _selectedTest,
                              items: _dropdownTestItems,
                              onChanged: onChangeDropdownTests,
                            ),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(text: "Do the personality test "),
                              TextSpan(
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
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
                            child: CustomTextField(
                              title: "Email",
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
                            child: CustomTextField(
                              title: "Password",
                              obscureText: true,
                              onChange: (password) => this.password = password,
                              validator: (text){
                                if(text.length == 0){
                                  return "Please fill this field";
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            width: Utils.getDesignWidth(100),
                            height: Utils.getDesignHeight(30),
                            margin: EdgeInsets.all(5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,),
                              onPressed: () {
                                if(_key.currentState.validate()){
                                  _key.currentState.save();
                                  FocusScope.of(context).unfocus();
                                  _signInSignUpBloc.registerUser(
                                    email: this.email,
                                    password: this.password,
                                    name: this.name,
                                    personality: this.personality
                                  );
                                }
                              },
                              child: Text(
                                "Register",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .button
                                    .copyWith(
                                      fontSize: 15,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: CustomButton(
                              name: 'Login',
                              borderColor: Theme.of(context).primaryColor,
                              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: Utils.getDesignWidth(100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.imagePath != '' ? Image.asset(
                      widget.imagePath,
                    ): Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onChangeDropdownTests(selectedTest) {
    personality = selectedTest['keyword'];
    setState(() {
      _selectedTest = selectedTest;
    });
    Provider.of<ThemeNotifier>(context, listen: false).themeNotifier('PersonalityTypes.${selectedTest['keyword']}');
  }
}
