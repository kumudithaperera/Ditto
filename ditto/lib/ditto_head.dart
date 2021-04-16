import 'package:ditto/bloc/registerBloc.dart';
import 'package:ditto/helper/appThemeData.dart';
import 'package:ditto/helper/colors.dart';
import 'package:ditto/screens/home_screen.dart';
import 'package:ditto/screens/login_screen.dart';
import 'package:ditto/screens/register_screen.dart';
import 'package:ditto/screens/welcome_screen.dart';
import 'package:ditto/screens/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (_, model, __){
          return MaterialApp(
            title: 'Ditto',
            debugShowCheckedModeBanner: false,
            theme: model.currentTheme,
            initialRoute: '/',
            routes: {
              '/': (context) => WelcomeScreen(),
              '/login': (context) => Provider(
                create: (c) => RegisterBloc(),
                child: LoginScreen(),
              ),
              '/register': (context) => RegisterScreen(logoPath: model.logoPath,),
              '/home': (context) => HomeScreen(logoPath: model.logoPath,),
              '/settings': (context) => SettingScreen(),
            },
          );
        },
      ),
    );
  }
}
