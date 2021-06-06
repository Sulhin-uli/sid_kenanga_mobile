import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sid_kenanga_mobile/ui/page/PageSplashScreen.dart';
import 'package:sid_kenanga_mobile/ui/page/kabar_desa/PageKabarDesa.dart';
import 'package:sid_kenanga_mobile/ui/page/login/PageSignIn.dart';
import 'package:sid_kenanga_mobile/ui/page/login/screens/SmalScreen.dart';
import 'package:sid_kenanga_mobile/ui/page/dashboard/PageDashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      theme: ThemeData(fontFamily: "RobotoSlab"),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageSplashScreen(),
      ),
      routes: <String, WidgetBuilder>{
        '/Dashboard': (BuildContext context) => new PageDashboard(),
        '/Login': (BuildContext context) => new PageSignIn(),
        '/HomeScreen': (BuildContext context) => new HomeScreen(),
      },
    );
  }
}
