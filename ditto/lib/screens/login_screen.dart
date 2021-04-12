import 'package:ditto/bloc/registerBloc.dart';
import 'package:ditto/helper/colors.dart';
import 'package:ditto/helper/util.dart';
import 'package:ditto/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  RegisterBloc _registerBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _registerBloc = Provider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
                          focusColor: primaryColorBasic,
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
                          focusColor: primaryColorBasic,
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
                          primary: primaryColorBasic
                        ),
                        onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                        // onPressed: () => _registerBloc.signIn("k@gmail.com", "1234567"),
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
          ],
        ),
      ),
    );
  }
}
