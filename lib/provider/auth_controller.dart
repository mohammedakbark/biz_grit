import 'dart:async';

import 'package:briz_grit/core/constant/string.dart';
import 'package:briz_grit/provider/hive_database.dart';
import 'package:briz_grit/screens/navigation_screen.dart';
import 'package:briz_grit/screens/splash_screen.dart';
import 'package:briz_grit/widgets/helper_widget.dart';
import 'package:briz_grit/widgets/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthController with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<void> createDataBase(
    String uid,
    userName,
    String password,
  ) async {
    db.collection(ConstString.userDbFirebase).doc(uid).set({
      ConstString.appPermission: true,
      ConstString.userName: userName,
      ConstString.password: password,
      ConstString.uid: uid
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) async {
    return db.collection(ConstString.userDbFirebase).doc(uid).get();
  }

  DocumentSnapshot<Map<String, dynamic>>? userData;
  Future<bool> checkTheAppPermission(String uid) async {
    userData = await getUserData(uid);
    if (userData!.exists) {
      if (userData!.data()![ConstString.appPermission] == true) {
        return true;
      } else {
        await auth.signOut();
        return false;
      }
    } else {
      await auth.signOut();

      return false;
    }
  }

  // Future<QuerySnapshot<Map<String, dynamic>>> getUserDataForCheck() async {
  //   return db.collection(ConstString.userDbFirebase).get();
  // }

  Future<void> loginUser(
      BuildContext context, String userName, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: '${userName}@gmail.com', password: password)
          .then((user) async {
        final userData = await getUserData(user.user!.uid);
        if (userData.exists) {
          final snapshot = await checkTheAppPermission(user.user!.uid);
          if (snapshot) {
            Provider.of<HiveDatabase>(context, listen: false)
                .takeHistoryFormCloud(context)
                .then((value) {
              Navigator.of(context).pushAndRemoveUntil(
                createRoute(SpalshScreen()),
                (route) => false,
              );
              // showCustomeSnackBar(context, "Login Successful !.", false);
            });
          } else {
            showCustomeSnackBar(
                context, "Your account is not activated !.", true);
          }
        } else {
          await createDataBase(user.user!.uid, userName, password)
              .then((value) async {
            Navigator.of(context).pushAndRemoveUntil(
              createRoute(const SpalshScreen()),
              (route) => false,
            );
            showCustomeSnackBar(context, "Login Successful !.", false);
          });
        }
        //  final snapshotUsers=   await  getUserDataForCheck();
        //  snapshotUsers.docs.map((e) => e[ConstString.uid])
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          {
            showCustomeSnackBar(context, "No user found for that email.", true);

            print("No user found for that email.");
            break;
          }

        case 'wrong-password':
          {
            showCustomeSnackBar(
                context, "Wrong password provided for that user.", true);

            print("Wrong password provided for that user.");
            break;
          }

        case 'invalid-email':
          {
            showCustomeSnackBar(
                context, 'The email address is not valid.', true);

            print("The email address is not valid.");
            break;
          }

        case 'user-disabled':
          {
            print("The user account has been disabled.");
            break;
          }

        default:
          {
            showCustomeSnackBar(context, "An error occurred: $e", true);
            print("An undefined error occurred: ${e.message}");
          }
      }
    } catch (e) {
      showCustomeSnackBar(context, "User not found", true);

      showCustomeSnackBar(context, "An error occurred: $e", true);
      print("An error occurred: $e");
    }
  }

  void logout() async {
   await auth.signOut();
  }
  // --------------History Data ------------
}
