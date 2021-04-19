import 'package:ditto/bloc/sign_in_sign_up_bloc.dart';
import 'package:ditto/helper/appThemeData.dart';
import 'package:ditto/helper/colors.dart';
import 'package:ditto/helper/util.dart';
import 'package:ditto/helper/validation.dart';
import 'package:ditto/service_locator.dart';
import 'package:ditto/services/navigation_service.dart';
import 'package:ditto/widgets/custom_button.dart';
import 'package:ditto/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _key = GlobalKey();

  SignInSignUpBloc _signInSignUpBloc;

  String email, password;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _signInSignUpBloc = Provider.of<SignInSignUpBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SecondaryColorBasic,
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
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Utils.getDesignWidth(100),
                        height: Utils.getDesignHeight(50),
                        margin: EdgeInsets.all(5),
                        child: CustomTextField(
                          title: "Email",
                          isConst: true,
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
                          isConst: true,
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
                        width: Utils.getDesignWidth(50),
                        height: Utils.getDesignHeight(30),
                        margin: EdgeInsets.all(5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: primaryColorBasic
                          ),
                          onPressed: () async {
                            if(_key.currentState.validate()){
                              _key.currentState.save();
                              FocusScope.of(context).unfocus();
                              await _signInSignUpBloc.loginUser(
                                email: this.email,
                                password: this.password,
                              ).then((isSuccess) async{
                                if(isSuccess) {
                                  await _signInSignUpBloc.getStudentDetails().then((value) {
                                    if(value){
                                      Provider.of<ThemeNotifier>(context, listen: false).themeNotifier(_signInSignUpBloc.getPersonalityType);
                                      _signInSignUpBloc.navigateToHomeScreen();
                                    }
                                  });
                                }
                              });
                            }
                          },
                          child: Text(
                            "Login",
                            style: Theme.of(context).primaryTextTheme.button.copyWith(
                                  fontSize: 15,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: CustomButton(
                          name: 'Register',
                          borderColor: primaryColorBasic,
                          onTap: () => Navigator.pushReplacementNamed(context, '/register'),
                        ),
                      ),
                    ],
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
