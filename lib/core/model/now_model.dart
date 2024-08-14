
import 'package:hive_flutter/adapters.dart';
part 'now_model.g.dart';
@HiveType(typeId: 4)

class NowModel {
    @HiveField(0)

  String lastRecordDate;

  NowModel({required this.lastRecordDate});
}
