import 'package:hive_flutter/adapters.dart';
part 'item_model.g.dart';

@HiveType(typeId: 1)
class ItemModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String wholesaleRate;
  @HiveField(3)
  String retailRate;
  @HiveField(4)
  String margin;

  ItemModel(
      {required this.id,
      required this.margin,
      required this.retailRate,
      required this.title,
      required this.wholesaleRate});
}
