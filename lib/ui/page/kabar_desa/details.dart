import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:sid_kenanga_mobile/ui/page/kabar_desa/shared/listitem.dart';

class DetailsScreen extends StatelessWidget {
  final Map kabar_desa;
  DetailsScreen({@required this.kabar_desa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                    tag: '${kabar_desa['judul']}',
                    child: Center(
                      child: Image.network(
                          "http://10.0.2.2:8000/img-kabar_desa/" +
                              kabar_desa['gambar']),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Text(
                        kabar_desa['judul'],
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
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
                            kabar_desa['tanggal'],
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(kabar_desa['isi'],
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 18.0)),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
