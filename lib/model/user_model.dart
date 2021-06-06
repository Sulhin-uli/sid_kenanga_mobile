import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  String nik;
  String name;
  String telp;
  String alamat;

  User({this.nik, this.name, this.telp, this.alamat});

  factory User.createUser(Map<String, dynamic> object) {
    return User(
      nik: object['nik'].toString(),
      name: object['name'],
      telp: object['no_hp'],
      alamat: object['alamat'],
    );
  }

  static Future<User> connectToAPI(String nik) async {
    String apiURL = "http://10.0.2.2:8000/api/user/" + nik;

    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>)['data'];

    return User.createUser(userData);
  }
}
