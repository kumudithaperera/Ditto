import 'package:ditto/helper/colors.dart';
import 'package:ditto/helper/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Utils.setScreenSizes(context);

    return Scaffold(
      backgroundColor: SecondaryColorBasic,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50.0),
              width: Utils.getDesignWidth(90),
              height: Utils.getDesignHeight(90),
              child: SvgPicture.asset("assets/images/logo.svg"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Utils.getDesignWidth(50),
                  height: Utils.getDesignHeight(50),
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColorBasic
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      "Login",
                      style: Theme.of(context).primaryTextTheme.button,
                    ),
                  ),
                ),
                Container(
                  width: Utils.getDesignWidth(50),
                  height: Utils.getDesignHeight(50),
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: primaryColorBasic
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: Text(
                      "Register",
                      style: Theme.of(context).primaryTextTheme.button,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
