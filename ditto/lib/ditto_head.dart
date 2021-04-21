import 'dart:async';

import 'package:ditto/bloc/home_screen_bloc.dart';
import 'package:ditto/bloc/loading_bloc.dart';
import 'package:ditto/bloc/settings_screen_bloc.dart';
import 'package:ditto/bloc/sign_in_sign_up_bloc.dart';
import 'package:ditto/bloc/test_bloc.dart';
import 'package:ditto/helper/appThemeData.dart';
import 'package:ditto/screens/home_screen.dart';
import 'package:ditto/screens/login_screen.dart';
import 'package:ditto/screens/register_screen.dart';
import 'package:ditto/screens/settings_screen.dart';
import 'package:ditto/screens/test_screen.dart';
import 'package:ditto/screens/welcome_screen.dart';
import 'package:ditto/service_locator.dart';
import 'package:ditto/services/base_managers/exceptions.dart';
import 'package:ditto/services/error_service.dart';
import 'package:ditto/services/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final ErrorService errorHandler = locator<ErrorService>();

  StreamSubscription _errorSubscription;
  Stream<SkeletonException> _prevErrorStream;

  @override
  void initState() {
    super.initState();

    Firebase.initializeApp();

    if(_prevErrorStream != errorHandler.getErrorText){
      _prevErrorStream = errorHandler.getErrorText;
      _errorSubscription?.cancel();
      listenToErrors();
    }
  }

  @override
  void dispose() {
    _errorSubscription?.cancel();
    errorHandler.dispose();
    super.dispose();
  }

  void listenToErrors(){
    _errorSubscription = _prevErrorStream.listen((error){
      locator<NavigationService>().showError(error.type, error.message, error.isSuccess);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (_, model, __){
          return MultiProvider(
            providers: [
              Provider<SignInSignUpBloc>(
                create: (_) => SignInSignUpBloc(),
              ),
              Provider<LoadingBloc>(
                create: (_) => LoadingBloc(),
                dispose: (_, bloc) => bloc.dispose(),
              ),
            ],
            child: MaterialApp(
              navigatorKey: locator<NavigationService>().navigatorKey,
              title: 'Ditto',
              debugShowCheckedModeBanner: false,
              theme: model.currentTheme,
              initialRoute: '/',
              routes: {
                '/': (context) => WelcomeScreen(),
                '/login': (context) => LoginScreen(),
                '/register': (context) => RegisterScreen(logoPath: model.logoPath,),
                '/home': (context) => Provider<HomeScreenBloc>(
                  create: (context) => HomeScreenBloc(),
                  child: HomeScreen(
                    logoPath: model.logoPath,
                  ),
                  dispose: (_, bloc) => bloc.dispose(),
                ),
                '/settings': (context) => Provider<SettingsScreenBloc>(
                  create: (context) => SettingsScreenBloc(),
                  child: SettingScreen(),
                  dispose: (_, bloc) => bloc.dispose(),
                ),
                '/test': (context) => Provider<TestBloc>(
                  create: (context) => TestBloc(),
                  child: TestScreen(),
                  dispose: (_, bloc) => bloc.dispose(),
                ),
              },
            ),
          );
        },
      ),
    );
  }
}
