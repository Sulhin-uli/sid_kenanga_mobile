import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sid_kenanga_mobile/ui/page/dashboard/PageDashboard.dart';
import 'package:sid_kenanga_mobile/ui/page/login/Animation/FadeAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PageSignIn extends StatefulWidget {
  @override
  _PageSignInState createState() => _PageSignInState();
}

class _PageSignInState extends State<PageSignIn> {
  bool isVisible = true;
  TextEditingController _controllerNik = TextEditingController();
  TextEditingController _controllerPin = TextEditingController();
  TextEditingController _controllerLevel = TextEditingController();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    checkSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background/background.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 25, top: 40),
                          child: IconButton(
                              iconSize: 30,
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                return Navigator.pop(context);
                              }),
                        ),
                        Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(left: 40),
                                    child: Text(
                                      "Hallo,",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(left: 40),
                                    child: Text(
                                      "Pengguna!",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ],
                            ),
                            FadeAnimation(
                              1.6,
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 40),
                                child: Image(
                                  image: AssetImage(
                                      "assets/ilustration/ilustration2.png"),
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          width: 330,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "NIK",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              TextField(
                                controller: _controllerNik,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffFE5A3F))),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Color(0xffFE5A3F),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 330,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "PIN",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              TextField(
                                controller: _controllerPin,
                                obscureText: true,
                                style: TextStyle(fontSize: 20),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xffFE5A3F)),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: Color(0xffFE5A3F),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          height: 60,
                          child: RaisedButton(
                            onPressed: () {
                              login();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffFE5A3F),
                                      Color(0xffE67332)
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 260.0, minHeight: 60.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    String nik = _controllerNik.text;
    String password = _controllerNik.text;
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response =
        await http.post(Uri.parse("http://10.0.2.2:8000/api/login"), body: {
      'nik': _controllerNik.text,
      'pin': _controllerPin.text,
      'is_admin': "0",
    });

    if (response.statusCode == 201) {
      pref.setString("nik", _controllerNik.text);
      Navigator.pushReplacementNamed(context, '/Dashboard');
      _key.currentState.showSnackBar(SnackBar(
        content: Text("NIK atau Pin PIN salah"),
        backgroundColor: Colors.red,
      ));
    } else {
      // print("Nik atau password salah");
      _key.currentState.showSnackBar(SnackBar(
        content: Text("NIK atau PIN salah"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<bool> checkSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.get("nik") != null) {
      Navigator.pushNamedAndRemoveUntil(context, '/Dashboard', (_) => false);
      return true;
    } else {
      return false;
    }
  }
}
