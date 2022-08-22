import 'package:flutter/material.dart';
import 'package:learn_flutter/app/app.dart';
import 'package:learn_flutter/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
