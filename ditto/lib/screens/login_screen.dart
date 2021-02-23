import 'package:ditto/helper/util.dart';
import 'package:ditto/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
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
                    onPressed: () => Navigator.pushNamed(context, '/home'),
                    child: Text(
                      "Login",
                      style: Theme.of(context).primaryTextTheme.button.copyWith(
                            fontSize: 15,
                          ),
                    ),
                  ),
                ),
                CustomButton(
                  name: 'Register',
                  onTap: () => Navigator.pushNamed(context, '/register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
