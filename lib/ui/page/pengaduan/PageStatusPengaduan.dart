import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sid_kenanga_mobile/ui/page/dashboard/PageDashboard.dart';
import 'model.dart';
import 'PageDetailStatus.dart';

class PageStatusPengaduan extends StatefulWidget {
  @override
  _PageStatusPengaduanState createState() => _PageStatusPengaduanState();
}

var nik = "";
var url = "http://10.0.2.2:8000/api/pengaduan/";

class _PageStatusPengaduanState extends State<PageStatusPengaduan> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _isiController = TextEditingController();

  Pengaduan pengaduan = null;

  String dropdownValue = 'First';
  Future savePengaduan() async {
    final response = await http.post(Uri.parse(url), body: {
      "nama": _namaController.text,
      "alamat": _alamatController.text,
      "tgl": "07-05-2021",
      "isi": _namaController.text,
      "status": "Terkirim",
    });
    return json.decode(response.body);
  }

  Future getPengaduan() async {
    var response = await http.get(Uri.parse(url + nik));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future pushNotifikasiPengaduan() async {
    final response = await http
        .post(Uri.parse("http://10.0.2.2:8000/api/notifikasi"), body: {
      "nama": nik,
      "aksi": "Mengirim Pesan Aduan ",
      "status": "Terkirim"
    });
    return json.decode(response.body);
  }

  Future<void> getSeesion() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nik = pref.get("nik");
    });
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
        title: Text('Status Pengaduan'),
      ),
      body: FutureBuilder(
        future: getPengaduan(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageDetailStatus(
                                    detailStatus: snapshot.data['data'][index],
                                  )));
                    },
                    child: Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            Text("Pengirim : ", style: TextStyle(fontSize: 15)),
                            Text(snapshot.data['data'][index]['nama'],
                                style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        subtitle: Text(
                            'Tanggal : ' + snapshot.data['data'][index]['tgl']),
                      ),
                    ),
                  );
                });
          } else {
            return Text('Memuat ...');
          }
        },
      ),
    );
  }
}
