import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:sid_kenanga_mobile/ui/page/kabar_desa/details.dart';
import 'package:intl/intl.dart';

class PageKabarDesa extends StatefulWidget {
  @override
  _PageKabarDesaState createState() => _PageKabarDesaState();
}

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('dd-MM-yyyy');
final String formatted = formatter.format(now);

class _PageKabarDesaState extends State<PageKabarDesa> {
  final String url = 'http://10.0.2.2:8000/api/kabar_desa';
  Future getKabarDesa() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4511E),
        title: Text('Kabar Desa'),
      ),
      body: FutureBuilder(
        future: getKabarDesa(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 1.0,
                      ),
                      child: Container(
                        height: 120,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                          kabar_desa: snapshot.data['data']
                                              [index],
                                        )));
                          },
                          child: Card(
                            elevation: 2.0,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Hero(
                                    tag:
                                        '${snapshot.data['data'][index]['judul']}',
                                    child: Container(
                                      width: 90.0,
                                      height: 90.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "http://10.0.2.2:8000/img-kabar_desa/" +
                                                  snapshot.data['data'][index]
                                                      ['gambar']),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 14.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data['data'][index]['judul'],
                                          style: TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Icon(Icons.date_range),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              formatter.format(
                                                DateTime.tryParse(
                                                    snapshot.data['data'][index]
                                                        ['tanggal']),
                                              ),
                                              // snapshot.data['data'][index]
                                              //     ['tanggal'],
                                              // formatted,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return Text('Loading ..');
          }
        },
      ),
    );
  }
}
