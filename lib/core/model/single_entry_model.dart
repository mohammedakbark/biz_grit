import 'package:hive_flutter/adapters.dart';
part 'single_entry_model.g.dart';

@HiveType(typeId: 2)
class SingleEntryModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String quantity;
  @HiveField(3)
  String margin;
  @HiveField(4)
  String sales;

  SingleEntryModel(
      {required this.id,
      required this.sales,
      required this.margin,
      required this.quantity,
      required this.title});
}
