import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pengaduan {
  String nik;
  String nama;

  Pengaduan({this.nik, this.nama});

  factory Pengaduan.createUser(Map<String, dynamic> object) {
    return Pengaduan(
      nik: object['nik'].toString(),
      nama: object['nama'],
    );
  }

  static Future<List<Pengaduan>> getPengaduan(String nik) async {
    String apiURL = "http://10.0.2.2:8000/api/pengaduan?nik=" + nik;

    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body);
    var pengaduanData = (jsonObject as Map<String, dynamic>)['data'];

    List<Pengaduan> pengaduan = [];
    for (int i = 0; i < pengaduanData.length; i++)
      pengaduan.add(Pengaduan.createUser(pengaduanData[i]));

    return pengaduan;
  }
}
