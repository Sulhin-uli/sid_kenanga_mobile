import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sid_kenanga_mobile/ui/page/login/screens/SmalScreen.dart';

class PageSplashScreen extends StatefulWidget {
  @override
  _PageSplashScreenState createState() => _PageSplashScreenState();
}

class _PageSplashScreenState extends State<PageSplashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return HomeScreen();
        }),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFE5A3F),
      body: Center(
        child: Image.asset(
          "assets/icons/sidk.png",
          width: 200,
          height: 100,
        ),
      ),
    );
  }
}
