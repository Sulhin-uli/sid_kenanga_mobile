import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sid_kenanga_mobile/model/user_model.dart';
import 'package:hb_check_code/hb_check_code.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';

var now = new DateTime.now();
var formatter = new DateFormat('dd-MM-yyyy');
String formattedDate = formatter.format(now);

String code = randomAlpha(5);

class SKDB extends StatefulWidget {
  @override
  _SKDBState createState() => _SKDBState();
}

class _SKDBState extends State<SKDB> {
  TextEditingController _namaPendudukController = TextEditingController();
  TextEditingController _namaSuratController = TextEditingController();
  String nik = "";
  String nama = "";
  User user = null;
  String msg = "";
  TextEditingController _capthaController = TextEditingController();

  TextEditingController _text1 =
      new TextEditingController(text: "Nama Bangunan : ");
  TextEditingController _text2 = new TextEditingController(text: "Alamat : ");

  Future jumlahnotif() async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/jumlah_notif"),
        body: {"ket": "1"});
    return json.decode(response.body);
  }

  Future save() async {
    if (code.toString() == _capthaController.text) {
      final response = await http
          .post(Uri.parse("http://10.0.2.2:8000/api/permintaan_surat"), body: {
        "nik": user.nik,
        "nama_penduduk": user.name,
        "nama_surat": "Surat Keterangan Domisili Bangunan",
        "status": "Terkirim",
        "tgl": formattedDate.toString(),
        "text1": _text1.text,
        "text2": _text2.text,
      });
      Navigator.pushReplacementNamed(context, '/Dashboard');
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Info"),
        content: Text("Permintaan Surat terkirim"),
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
      pushNotifikasiSurat();
      jumlahnotif();
      return json.decode(response.body);
    } else {
      setState(() {
        msg = "Kode captcha salah";
      });
    }
  }

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

  Future pushNotifikasiSurat() async {
    final response = await http
        .post(Uri.parse("http://10.0.2.2:8000/api/notifikasi"), body: {
      "nik": user.nik,
      "nama": user.name,
      "aksi": "Permintaan Surat Keterangan Domisili Bangunan",
      "status": "Terkirim"
    });
    return json.decode(response.body);
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
          // title: Text('Login Screen App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Card(
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Surat Keterangan Domisili Bangunan',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "1. Data Pemohon",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  controller: _text1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      "contoh : TK. PGRI BANGSA INDAH",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _text2,
                  minLines:
                      6, // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      "contoh :  Blok Teluk RT.012 RW.004 Desa Kenanga Kec.Sindang",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Text(
                  "Kab.Indramayu",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4),
                  child: Row(
                    children: [
                      Text("Captcha: ",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      Card(
                        child: HBCheckCode(
                          code: code,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                          child: Row(
                            children: [
                              InkWell(child: Icon(Icons.refresh)),
                              Text("Refresh")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text("*",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        )),
                    Text(
                        "Untuk pengisian captcha mohon diperhatikan huruf kecil dan besarnya.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Text("*",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        )),
                    Text(
                        "Sebelum menekan tombol kirim, mohon diperiksa kembali datanya ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        )),
                  ],
                ),
                Text(
                    "    apakah pengisian sudah sesuai atau ada kesalahan penulisan.",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    )),
                Card(
                  child: TextFormField(
                    controller: _capthaController,
                    minLines:
                        1, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ketikkan Captha',
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                new Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text('Kirim'),
                      onPressed: () {
                        save();
                      },
                    )),
                SizedBox(
                  height: 30,
                ),
              ],
            )));
  }
}

class NamaSurat {
  String nama;
  NamaSurat(this.nama);
}
