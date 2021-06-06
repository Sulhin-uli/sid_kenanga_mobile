import 'package:flutter/material.dart';
import 'package:sid_kenanga_mobile/ui/page/kabar_desa/PageKabarDesa.dart';
import 'package:sid_kenanga_mobile/ui/page/login/Animation/FadeAnimation.dart';
import 'package:sid_kenanga_mobile/ui/page/login/PageSignIn.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[Color(0xffFE5A3F), Color(0xffE67332)],
        )),
        child: Container(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 40, top: 50),
              child: Image(
                image: AssetImage("assets/icons/sidk.png"),
                height: 70,
                width: 70,
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 40, top: 30),
                    child: Text(
                      "SID",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    )),
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 40, top: 60),
                    child: Text(
                      "Kenanga",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
                FadeAnimation(
                  2.5,
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    padding: EdgeInsets.only(left: 120, top: 50),
                    child: Image(
                      image: AssetImage("assets/ilustration/ilustration4.png"),
                      height: 320,
                      width: 320,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 160,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 260,
                    child: MaterialButton(
                      child: Text(
                        "Kabar Desa",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        return Navigator.push(context,
                            MaterialPageRoute(builder: (_) => PageKabarDesa()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Colors.white, width: 2)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    width: 260,
                    child: MaterialButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Colors.white, width: 2)),
                      onPressed: () {
                        return Navigator.push(context,
                            MaterialPageRoute(builder: (_) => PageSignIn()));
                      },
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xffFE5A3F), fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
