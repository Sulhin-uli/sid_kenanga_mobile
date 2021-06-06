import 'package:flutter/material.dart';

class PageDetailStatus extends StatelessWidget {
  final Map detailStatus;
  PageDetailStatus({@required this.detailStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Text("Pengirim :",
                style: TextStyle(
                  fontSize: 15,
                )),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, bottom: 15, top: 5),
            child: Text(detailStatus['nama'],
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
            child: Text(detailStatus['tgl'], style: TextStyle(fontSize: 16)),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Text("Isi aduan :",
                style: TextStyle(
                  fontSize: 15,
                )),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(detailStatus['isi'], style: TextStyle(fontSize: 16)),
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
        ]),
      ),
    );
  }
}
