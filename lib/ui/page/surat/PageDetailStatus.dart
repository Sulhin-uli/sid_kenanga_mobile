import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sid_kenanga_mobile/model/user_model.dart';
import 'package:hb_check_code/hb_check_code.dart';

class PageDetailStatus extends StatelessWidget {
  final Map detailStatus;
  PageDetailStatus({@required this.detailStatus});
  TextEditingController _alasanController = TextEditingController();
  TextEditingController _capthaController = TextEditingController();
  String msg = "";

  @override
  Widget build(BuildContext context) {
    Future jumlahnotif() async {
      final response = await http.post(
          Uri.parse("http://10.0.2.2:8000/api/jumlah_notif"),
          body: {"ket": "1"});
      return json.decode(response.body);
    }

    Future batal() async {
      final response = await http
          .post(Uri.parse("http://10.0.2.2:8000/api/notifikasi"), body: {
        "nik": detailStatus['nik'].toString(),
        "nama": detailStatus['nama_penduduk'],
        "aksi": "Membatalkan Pembuatan " + detailStatus['nama_surat'],
        "status": "Terkirim",
        "alasan": _alasanController.text
      });
      Navigator.pushReplacementNamed(context, '/Dashboard');
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Info"),
        content: Text("Permintaan Pembatalan terkirim"),
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
      jumlahnotif();
      return json.decode(response.body);
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
          batal();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Info"),
        content: Text("Apakah Yakin akan membatalkan?"),
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

    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20, left: 15),
          child: Text("Pengirim :",
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        Container(
          padding: EdgeInsets.only(left: 15, bottom: 15, top: 5),
          child: Text(detailStatus['nama_penduduk'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: EdgeInsets.only(top: 20, left: 15),
          child: Text("Tanggal :",
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        Container(
          padding: EdgeInsets.only(left: 15, bottom: 15, top: 5),
          child:
              Text(detailStatus['created_at'], style: TextStyle(fontSize: 16)),
        ),
        Container(
          padding: EdgeInsets.only(top: 20, left: 15),
          child: Text("Surat :",
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child:
              Text(detailStatus['nama_surat'], style: TextStyle(fontSize: 16)),
        ),
        Container(
          padding: EdgeInsets.only(top: 20, left: 15),
          child: Text("Status :",
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        Container(
          padding: EdgeInsets.only(left: 15, bottom: 15, top: 5),
          child: Text(detailStatus['status'],
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: EdgeInsets.only(top: 20, left: 15),
          child: Text("Batalkan Permintaan Pembuatan Surat.",
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text("Alasan : "),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
          child: TextFormField(
            controller: _alasanController,
            minLines:
                2, // any number you need (It works as the rows for the textarea)
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
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
                    "Batalkan",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
