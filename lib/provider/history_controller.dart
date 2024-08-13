import 'package:briz_grit/core/constant/string.dart';
import 'package:briz_grit/core/model/history_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class HistoryController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

 Future<void> addToHistory(HistoryModel historyModel)async {
  await  db
        .collection(ConstString.userDbFirebase)
        .doc(auth.currentUser!.uid)
        .collection(ConstString.historyDb)
        .doc(historyModel.date)
        .set(historyModel.toJson());
  }

 Future<QuerySnapshot<Map<String, dynamic>>> getAllHistory()async {
   return  await db
        .collection(ConstString.userDbFirebase)
        .doc(auth.currentUser!.uid)
        .collection(ConstString.historyDb)
        .get();
  }
}
