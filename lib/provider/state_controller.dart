import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:flutter/material.dart';

class StateController with ChangeNotifier {
  int currentPage = 0;

  changePage(selectedPage) {
    currentPage = selectedPage;
    notifyListeners();
  }

  bool enableSearchList = false;
  checkSearchControllerNotEmpty(String value, List<String> data) async {
    if (value.isEmpty) {
      enableSearchList = false;
      notifyListeners();
    } else {
      enableSearchList = true;
      _checkFromTheList(value, data);

      notifyListeners();
    }
  }

  List<String> searchResult = [];
  _checkFromTheList(String searchKey, List<String> data) {
    final search = List<String>.from(data);
    searchResult = search
        .where((element) =>
            element.toLowerCase().contains(searchKey.toLowerCase()))
        .toList();
  }

  disAbleSearchList() {
    enableSearchList = false;
    notifyListeners();
  }

 static  bool checkTheValueContainInDatabase(String controller, List<String> data) {
    if (data.contains(controller)) {
      return true;
    } else {
      return false;
    }
  }
}
