import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sid_kenanga_mobile/ui/page/dashboard/PageDashboard.dart';
import 'package:sid_kenanga_mobile/ui/page/pengaduan/PageStatusPengaduan.dart';
import 'package:sid_kenanga_mobile/model/user_model.dart';
import 'package:hb_check_code/hb_check_code.dart';
import 'dart:math';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';

var now = new DateTime.now();
var formatter = new DateFormat('dd-MM-yyyy');
String code = randomAlpha(5);
String formattedDate = formatter.format(now);

class PagePengaduan extends StatefulWidget {
  @override
  _PagePengaduanState createState() => _PagePengaduanState();
}

class _PagePengaduanState extends State<PagePengaduan> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _isiController = TextEditingController();
  TextEditingController _capthaController = TextEditingController();
  String nik = "";
  String dropdownValue = 'First';
  User user = null;
  String msg = "";

  Future pushNotifikasiPengaduan() async {
    final response = await http
        .post(Uri.parse("http://10.0.2.2:8000/api/notifikasi"), body: {
      "nik": nik,
      "nama": user.name,
      "aksi": "Mengirim Pesan Aduan ",
      "status": "Terkirim"
    });
    return json.decode(response.body);
  }

  Future jumlahnotif() async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/jumlah_notif"),
        body: {"ket": "1"});
    return json.decode(response.body);
  }

  Future<void> getSeesion() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nik = pref.get("nik");
      User.connectToAPI(nik).then((value) {
        user = value;
        setState(() {});
      });
    });
  }

  Future savePengaduan() async {
    if (code.toString() == _capthaController.text) {
      final response = await http
          .post(Uri.parse("http://10.0.2.2:8000/api/pengaduan"), body: {
        "nama": user.name.toString(),
        "nik": nik,
        "alamat": user.alamat,
        "tgl": formattedDate.toString(),
        "isi": _isiController.text,
        "status": "Terkirim",
      });
      Navigator.pushReplacementNamed(context, '/Dashboard');
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Info"),
        content: Text("Pesan aduan terkirim"),
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
      pushNotifikasiPengaduan();
      jumlahnotif();
      return json.decode(response.body);
    } else {
      setState(() {
        msg = "Kode captcha salah";
      });
    }
  }

  @override
  void initState() {
    getSeesion();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF4511E),
        ),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text("Pengaduan Masyarakat",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4),
                  child: Text("Isi aduan :",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ),
                Card(
                  child: TextFormField(
                    controller: _isiController,
                    minLines:
                        6, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ketikkan isi aduan',
                    ),
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
                    Text("maksimal 255 karakter.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        )),
                  ],
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
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text('Kirim'),
                      onPressed: () {
                        savePengaduan();
                      },
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Cek Status Pengaduan'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageStatusPengaduan()));
                      },
                    )),
                // Container(
                //     alignment: Alignment.center,
                //     child: HBCheckCode(
                //       code: code,
                //     )),
                // InkWell(
                //     onTap: () {
                //       setState(() {});
                //     },
                //     child: Icon(Icons.refresh)),
                // Container(
                //   child: Text(code.toString()),
                // ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: DataTable(
                //     columns: <DataColumn>[
                //       DataColumn(label: Text("Akun")),
                //       DataColumn(label: Text("Nama")),
                //       DataColumn(label: Text("tanggal")),
                //       DataColumn(label: Text("status")),
                //     ],
                //     rows: <DataRow>[
                //       DataRow(
                //         cells: <DataCell>[
                //           DataCell(Text("Frozen Yogurt")),
                //           DataCell(Text("159")),
                //           DataCell(Text("6.0")),
                //           DataCell(Text("4.0")),
                //         ],
                //       ),
                //       DataRow(
                //         cells: <DataCell>[
                //           DataCell(Text("Ice Cream Sandwich")),
                //           DataCell(Text("237")),
                //           DataCell(Text("9.0")),
                //           DataCell(Text("4.3")),
                //         ],
                //       ),
                //       DataRow(
                //         cells: <DataCell>[
                //           DataCell(Text("Eclair")),
                //           DataCell(Text("262")),
                //           DataCell(Text("16.0")),
                //           DataCell(Text("6.0")),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
              ],
            )));
  }
}
