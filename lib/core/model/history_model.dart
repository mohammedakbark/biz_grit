import 'package:flutter/material.dart';

class HistoryModel {
  String id;
  DateTime date;
  String totalSales;
  String totalMargin;

  HistoryModel(
      {required this.date,
      required this.id,
      required this.totalMargin,
      required this.totalSales});


}
