import 'package:briz_grit/core/model/item_model.dart';
import 'package:flutter/material.dart';

class StateController with ChangeNotifier {
  int currentPage = 0;

  changePage(selectedPage) {
    currentPage = selectedPage;
    notifyListeners();
  }

  bool enableSearchList = false;
  checkSearchControllerNotEmpty(String value, List<ItemModel> data) async {
    if (value.isEmpty) {
      enableSearchList = false;
      notifyListeners();
    } else {
      enableSearchList = true;
      _checkFromTheList(value, data);

      notifyListeners();
    }
  }

  List<ItemModel> searchResult = [];
  _checkFromTheList(String searchKey, List<ItemModel> data) {
    final search = List<ItemModel>.from(data);

    searchResult = search
        .where((element) =>
            element.title.toLowerCase().contains(searchKey.toLowerCase()))
        .toList();
  }

  disAbleSearchList() {
    enableSearchList = false;
    notifyListeners();
  }

  static bool checkTheValueContainInDatabase(
      ItemModel controller, List<ItemModel> data) {
    if (data.contains(controller)) {
      return true;
    } else {
      return false;
    }
  }
}
