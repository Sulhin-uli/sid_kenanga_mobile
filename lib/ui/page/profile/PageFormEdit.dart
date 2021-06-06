import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sid_kenanga_mobile/ui/page/login/PageSignIn.dart';
import 'package:sid_kenanga_mobile/model/user_model.dart';
import 'package:sid_kenanga_mobile/ui/page/profile/PageFormEdit.dart';
import 'package:http/http.dart' as http;
import 'package:sid_kenanga_mobile/ui/page/profile/PageProfile.dart';

class EditData extends StatefulWidget {
  @override
  _EditDataState createState() => new _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController controllerPIN0 = TextEditingController();
  TextEditingController controllerPIN = TextEditingController();
  TextEditingController controllerPIN2 = TextEditingController();
  User user = null;
  String nik = "";
  String msg = "";

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nik = pref.get("nik");
      User.connectToAPI(nik).then((value) {
        user = value;
        setState(() {
          // controllerNamaTim = new TextEditingController(text: user.name);
        });
      });
    });
  }

  Future<void> edit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response =
        await http.post(Uri.parse("http://10.0.2.2:8000/api/login"), body: {
      'nik': nik.toString(),
      'pin': controllerPIN0.text,
      'is_admin': "0",
    });

    if (response.statusCode == 201) {
      editData();
    } else {
      // print("Nik atau password salah");
      setState(() {
        msg = "PIN lama tidak sesuai";
      });
    }
  }

  Future<void> editData() async {
    if (controllerPIN.text == controllerPIN2.text) {
      final response = await http.put(
          Uri.parse("http://10.0.2.2:8000/api/user/" + nik.toString()),
          body: {
            "pin": controllerPIN.text,
          });
      Navigator.pushReplacementNamed(context, '/Dashboard');
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Info"),
        content: Text("PIN berhasil diubah"),
        actions: [
          FlatButton(
              child: Text(""),
              onPressed: () {
                //  Navigator.pop(context,alert);
              }),
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return alert;
        },
      );
    } else {
      setState(() {
        msg = "PIN baru dan Konfirmasi Pin baru tidak sama";
      });
    }
  }

  @override
  void initState() {
    getSession();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                Card(
                    child: ListTile(
                  title: Text(
                    "Ubah PIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 19),
                  ),
                )),
                new TextField(
                  obscureText: true,
                  controller: controllerPIN0,
                  decoration: new InputDecoration(labelText: "PIN Lama"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                new TextField(
                  obscureText: true,
                  controller: controllerPIN,
                  decoration: new InputDecoration(labelText: "PIN Baru"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                new TextField(
                  obscureText: true,
                  controller: controllerPIN2,
                  decoration:
                      new InputDecoration(labelText: "Konfirmasi PIN Baru "),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Row(
              children: [
                new Text(
                  "*",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.red),
                ),
                new Text(
                  "PIN harus diisi dengan angka",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Simpan'),
                  onPressed: () {
                    edit();
                  },
                )),
            SizedBox(
              height: 10,
            ),
            new Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
