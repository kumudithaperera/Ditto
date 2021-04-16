import 'package:ditto/ditto_head.dart';
import 'package:ditto/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
