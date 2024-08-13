import 'package:hive_flutter/adapters.dart';
part 'history_model.g.dart';

@HiveType(typeId: 3)
class HistoryModel {
  @HiveField(0)
  String date;
  @HiveField(1)
  String totalSales;
  @HiveField(2)
  String totalMargin;

  HistoryModel(
      {required this.totalSales,
      required this.date,
      required this.totalMargin});

  Map<String, dynamic> toJson() =>
      {'date': date, 'totalSales': totalSales, 'totalMargin': totalMargin};
  factory HistoryModel.fromjson(Map<String, dynamic> json) {
    return HistoryModel(
        totalSales: json['totalSales'],
        date: json['date'],
        totalMargin: json['totalMargin']);
  }
}
