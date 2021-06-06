import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VisiMisi {
  String id;
  String visi;

  VisiMisi({this.id, this.visi});

  factory VisiMisi.createUser(Map<String, dynamic> object) {
    return VisiMisi(
      id: object['id_visimisi'].toString(),
      visi: object['visi'],
    );
  }

  static Future<VisiMisi> connectToAPI(String id) async {
    String apiURL = "http://10.0.2.2:8000/api/visi_misi/" + id;

    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>)['data'];

    return VisiMisi.createUser(userData);
  }
}
