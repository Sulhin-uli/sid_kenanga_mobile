import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sid_kenanga_mobile/ui/page/dashboard/constants/style_constant.dart';
import 'package:sid_kenanga_mobile/ui/page/login/PageSignIn.dart';
import 'package:sid_kenanga_mobile/model/user_model.dart';
import 'package:sid_kenanga_mobile/ui/page/profile/PageFormEdit.dart';

class PageProfile extends StatefulWidget {
  @override
  _PageProfileState createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  User user = null;
  String nik = "";

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nik = pref.get("nik");
      User.connectToAPI(nik).then((value) {
        user = value;
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    getSession();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4511E),
      ),
      body: ListView(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20, left: 15),
          child: Text("Nama :",
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        Container(
          padding: EdgeInsets.only(left: 15, bottom: 15, top: 5),
          child: Text((user != null) ? user.name : "memuat",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 24),
          child: Row(
            children: [
              RaisedButton(
                  color: Colors.orange,
                  onPressed: () =>
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new EditData(),
                      )),
                  child: Text(
                    "Edit Pin",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, bottom: 5),
          child: Text(
            'Logout',
            style: mTitleStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 24),
          child: Row(
            children: [
              RaisedButton(
                  color: Colors.orange,
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("nik");
    Navigator.pushNamedAndRemoveUntil(context, '/HomeScreen', (_) => false);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Batal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ya"),
      onPressed: () {
        logout();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Apakah Yakin akan Logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
