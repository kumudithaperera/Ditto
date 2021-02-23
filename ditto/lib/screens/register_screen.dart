import 'package:ditto/helper/util.dart';
import 'package:ditto/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                      labelText: 'Name',
                    ),
                  ),
                ),
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
                    onPressed: () {},
                    child: Text(
                      "Register",
                      style: Theme.of(context).primaryTextTheme.button.copyWith(
                            fontSize: 15,
                          ),
                    ),
                  ),
                ),
                CustomButton(
                  name: 'Login',
                  onTap: () => Navigator.pushNamed(context, '/login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
