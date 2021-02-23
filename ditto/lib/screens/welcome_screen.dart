import 'package:ditto/helper/util.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Utils.getDesignWidth(50),
              height: Utils.getDesignHeight(50),
              margin: EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
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
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  "Register",
                  style: Theme.of(context).primaryTextTheme.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
