import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sid_kenanga_mobile/ui/page/dashboard/PageDashboard.dart';

class PageProfiDesa extends StatefulWidget {
  @override
  _PageProfiDesaState createState() => _PageProfiDesaState();
}

class _PageProfiDesaState extends State<PageProfiDesa> {
  var url = "http://10.0.2.2:8000/api/visi_misi";

  Future getPengaduan() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4511E),
      ),
      body: FutureBuilder(
        future: getPengaduan(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Text("Profil Desa",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 19)),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text("Alamat",
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 15)),
                            subtitle: Text(
                                "Jl. Pesarean No.0255 45213, Kenanga, Sindang, Kabupaten Indramayu, Jawa Barat 45226"),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text("Visi", style: TextStyle(fontSize: 15)),
                            subtitle: Text(
                              snapshot.data['data'][index]['visi'],
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text("Misi", style: TextStyle(fontSize: 15)),
                            subtitle: Text(snapshot.data['data'][index]['misi'],
                                textAlign: TextAlign.justify),
                          ),
                        ),
                      ],
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
