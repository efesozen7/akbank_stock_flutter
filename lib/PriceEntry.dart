import 'package:flutter/cupertino.dart';

class PriceEntry {
  double c;
  int d;

  PriceEntry({@required this.c, @required this.d});

  factory PriceEntry.fromJson(Map<String, dynamic> json){
    return PriceEntry(c: json['c'].toDouble() as double, d: json['d']);
  }
}