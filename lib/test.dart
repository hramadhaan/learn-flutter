import 'package:flutter/material.dart';
import 'package:learn_flutter/app/app.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  void updateState() {
    MyApp.instance.appState = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
