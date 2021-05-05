import 'package:flutter/src/material/list_tile.dart';
import 'package:finfree_akbank/PriceEntry.dart';

class AkbankData {
  List<PriceEntry> d_1h;
  List<PriceEntry> d_1y;
  List<PriceEntry> d_5y;
  List<PriceEntry> d_1g;
  List<PriceEntry> d_1a;
  List<PriceEntry> d_3a;

  AkbankData({this.d_1g, this.d_1a, this.d_3a, this.d_1h, this.d_1y, this.d_5y});

  factory AkbankData.fromJson(Map<String, dynamic> json){

    var g1 = json['1G'] as List;
    var a1 = json['1A'] as List;
    var h1 = json['1H'] as List;
    var a3 = json['3A'] as List;
    var y1 = json['1Y'] as List;
    var y5 = json['5Y'] as List;

    return AkbankData(
      d_1g: g1.map((i) => PriceEntry.fromJson(i)).toList(),
      d_1a: a1.map((i) => PriceEntry.fromJson(i)).toList(),
      d_1h: h1.map((i) => PriceEntry.fromJson(i)).toList(),
      d_3a: a3.map((i) => PriceEntry.fromJson(i)).toList(),
      d_1y: y1.map((i) => PriceEntry.fromJson(i)).toList(),
      d_5y: y5.map((i) => PriceEntry.fromJson(i)).toList()
    );
  }
}