import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:finfree_akbank/AkbankData.dart';
import 'dart:convert';
import 'package:finfree_akbank/PriceEntry.dart';

class Service {

  static const String url = "finfree.app";
  final String authStr = 'R29vZCBMdWNr';
  final Uri uri = Uri.https(url, "/demo");

  Future<AkbankData> getData() async {
    Response resp = await get(uri, headers: {"authorization" : authStr });
    print(resp.statusCode);
    print(resp.body);
    if(resp.statusCode == 200){
      dynamic body = json.decode(resp.body);
      AkbankData data = AkbankData.fromJson(body);
      //debugPrint(data.d_1h[0].c.toString());
      return data;
    }else{
      throw "Couldn't fetch data";
    }
  }
}