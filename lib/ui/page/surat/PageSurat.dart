import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sid_kenanga_mobile/model/user_model.dart';
import 'package:sid_kenanga_mobile/ui/page/dashboard/PageDashboard.dart';
import 'package:sid_kenanga_mobile/ui/page/surat/PageStatusPermintaanSurat.dart';
import 'package:sid_kenanga_mobile/ui/page/surat/page_spesifik/PageLainnya.dart';
import 'package:sid_kenanga_mobile/ui/page/surat/page_spesifik/PageSGG.dart';
import 'package:sid_kenanga_mobile/ui/page/surat/page_spesifik/PageSKDB.dart';
import 'package:sid_kenanga_mobile/ui/page/surat/page_spesifik/PageSKDCV.dart';
import 'package:sid_kenanga_mobile/ui/page/surat/page_spesifik/PageSKDKU.dart';
import 'package:sid_kenanga_mobile/ui/page/surat/page_spesifik/PageSKDP.dart';
import 'package:sid_kenanga_mobile/ui/page/surat/page_spesifik/PageSKPindah.dart';
import 'package:sid_kenanga_mobile/ui/page/surat/page_spesifik/PageSuketUsaha.dart';

class PageSurat extends StatefulWidget {
  @override
  _PageSuratState createState() => _PageSuratState();
}

class _PageSuratState extends State<PageSurat> {
  TextEditingController _namaPendudukController = TextEditingController();
  TextEditingController _namaSuratController = TextEditingController();
  String nik = "";
  String nama = "";
  User user = null;

  // combo box surat
  NamaSurat pilihSurat;
  List<NamaSurat> surats = [
    NamaSurat("Surat Keterangan Usaha"),
    NamaSurat("Surat Keterangan Domisili")
  ];
  List<DropdownMenuItem> generateItems(List<NamaSurat> persons) {
    List<DropdownMenuItem> items = [];
    for (var item in surats) {
      items.add(DropdownMenuItem(
        child: Text(item.nama),
        value: item,
      ));
    }
    return items;
  }

  Future savePengaduan() async {
    final response = await http
        .post(Uri.parse("http://10.0.2.2:8000/api/permintaan_surat"), body: {
      "nik": user.nik,
      "nama_penduduk": user.name,
      "nama_surat": _namaSuratController.text,
      "status": "Terkirim",
    });
    return json.decode(response.body);
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
      "aksi": "Mengirim Permintaan Pembuatan Surat",
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
                  child: ListTile(
                    title: Text("Permintaan Pembuatan Surat",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 10),
                  child: Text("Status Permintaan Surat",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text(
                          'Cek Status Permintaan Surat',
                          textAlign: TextAlign.start,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PageStatusPermintaanSurat()));
                        })),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 10),
                  child: Text("Pilih Surat",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SuketUsaha()));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("1."),
                      title: Text("Surat Keterangan Usaha"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SKDCV()));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("2."),
                      title: Text("Surat Keterangan Domisili CV"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SKDP()));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("3."),
                      title: Text("Surat Keterangan Domisili Perusahaan"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SKDB()));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("4."),
                      title: Text("Surat Keterangan Domisili Bangunan"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SKDKU()));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("5."),
                      title: Text("Surat Keterangan Domisili Kelompok Usaha"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SKGG()));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("6."),
                      title: Text("Surat Gempur Gakin Sktm"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SKPindah()));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("7."),
                      title: Text("Surat Keterangan Pindah"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => SKTM()));
                //   },
                //   child: Card(
                //     child: ListTile(
                //       leading: Text("8."),
                //       title: Text("Surat Pernyataan Keterangan Tidak Mampu"),
                //       trailing: Icon(Icons.arrow_forward_ios),
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Slainnya()));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("9."),
                      title: Text("Surat Lainnya"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ],
            )));
  }
}

class NamaSurat {
  String nama;
  NamaSurat(this.nama);
}
