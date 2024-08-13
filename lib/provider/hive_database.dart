import 'dart:developer';

import 'package:briz_grit/core/constant/string.dart';
import 'package:briz_grit/core/model/history_model.dart';
import 'package:briz_grit/core/model/item_model.dart';
import 'package:briz_grit/core/model/single_entry_model.dart';
import 'package:briz_grit/provider/history_controller.dart';
import 'package:briz_grit/widgets/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class HiveDatabase with ChangeNotifier {
  List<ItemModel> _itemList = [];
  List<ItemModel> get itemList => _itemList;

  Future clearItemList() async {
    _itemList.clear();
    itemList.clear();
  }

  Future<bool> _checkTheItemAlreadyInCart(String key) async {
    final itemBox = await Hive.openBox<ItemModel>(ConstString.itemDb);
    final outPut = itemBox.get(
      key,
    );

    log(key);
    log(outPut.toString());
    if (outPut == null) {
      log('the item not exisit');
      return false;
    } else {
      log('the item already exist');
      return true;
    }
  }

  void addNewItem(BuildContext context, ItemModel itemModel) async {
    final snapshot = await _checkTheItemAlreadyInCart(itemModel.id);

    if (!snapshot) {
      await clearItemList();
      final itemBox = await Hive.openBox<ItemModel>(ConstString.itemDb);
      itemBox.put(itemModel.id, itemModel);

      showCustomeSnackBar(context, '${itemModel.title} is added', false);
    } else {
      showCustomeSnackBar(context, 'This item is already exist !!', true);
    }
  }

  Future<List<ItemModel>> getAllItems() async {
    log('future invoked');

    try {
      final itemBox = await Hive.openBox<ItemModel>(ConstString.itemDb);
      await clearItemList();

      if (itemBox.isNotEmpty) {
        _itemList.addAll(itemBox.values);
      }
    } catch (e) {
      log(e.toString());
    }
    return _itemList;
  }

  void removeItem(String id) async {
    final itemBox = await Hive.openBox<ItemModel>(ConstString.itemDb);
    itemBox.delete(id);
    notifyListeners();
  }

  void updateItem(ItemModel model) async {
    final itemBox = await Hive.openBox<ItemModel>(ConstString.itemDb);
    itemBox.put(model.id, model);
  }

  //----------------Entries-----------

  final List<SingleEntryModel> _entryList = [];
  List<SingleEntryModel> get entryList => _entryList;

  clearEntryList() {
    _entryList.clear();

    entryList.clear();
  }

  Future addNewEntry(BuildContext context, SingleEntryModel entryModel) async {
    final entryBox =
        await Hive.openBox<SingleEntryModel>(ConstString.dailyEntryDb);
    entryBox.put(entryModel.id, entryModel);
    showCustomeSnackBar(context, 'Entry successful', false);
    calculateTotlaMargin();
    notifyListeners();
  }

  Future<List<SingleEntryModel>> getEntries() async {
    final entryBox =
        await Hive.openBox<SingleEntryModel>(ConstString.dailyEntryDb);
    await clearEntryList();
    _entryList.addAll(entryBox.values);
    log(_entryList.length.toString());

    return _entryList;
  }

  void removeEntries(String key) async {
    final entryBox =
        await Hive.openBox<SingleEntryModel>(ConstString.dailyEntryDb);
    entryBox.delete(key);
    calculateTotlaMargin();
    notifyListeners();
  }

  //-----------------  total margin  ------------
  double _totalSales = 0;

  double get totalSales => _totalSales;

  double _totlaMargin = 0;

  double get totalMargin => _totlaMargin;
  HistoryModel? _historyModel;

  HistoryModel? historyModel;

  final dateFormat = DateFormat('dd-MM-yyyy');
  Future<void> calculateTotlaMargin() async {
    final now = dateFormat.format(DateTime.now());

    _totalSales = 0;
    _totlaMargin = 0;
    final entries = await getEntries();
    // cleanEntryBx();
    for (var entry in entries) {
      final sales = double.parse(entry.sales);
      final margin = double.parse(entry.margin);
      _totalSales += sales;
      _totlaMargin += margin;
    }
    log('total margin= ${_totlaMargin}\nTtal sales = ${_totalSales}');
    _historyModel = HistoryModel(
        totalSales: _totalSales.toString(),
        date: now,
        totalMargin: _totlaMargin.toString());

    log(_historyModel!.date);
  }

  cleanEntryBx() async {
    final box = await Hive.openBox<SingleEntryModel>(ConstString.dailyEntryDb);
    box.clear();
  }

  resetLastDayData() async {
    _totalSales = 0;
    _totlaMargin = 0;
    await cleanEntryBx();
    notifyListeners();
  }

  //--------------history db -----------------
  List<HistoryModel> _historylist = [];
  List<HistoryModel> get historyList => _historylist;

  clearHistoryList() {
    _historylist.clear();
    historyList.clear();
  }

  Future<bool> _confirmToAddHistory() async {
    final now = dateFormat.format(DateTime.now());
    await calculateTotlaMargin();
    if (_historyModel != null) {
      if (now != _historyModel!.date) {
        print('1');
        return true;
      } else {
        print('2');

        return false;
      }
    } else {
      print('3');

      return false;
    }
  }

  Future addToHistory() async {
    final confirm = await _confirmToAddHistory();

    if (confirm) {
      await HistoryController()
          .addToHistory(_historyModel!)
          .then((value) async {
        final historybox =
            await Hive.openBox<HistoryModel>(ConstString.historyDb);
        await historybox.put(_historyModel!.date, _historyModel!);
        resetLastDayData();
      });
    } else {
      log('-----------May history last day model nullm or history transferd');
    }
  }

  Future<List<HistoryModel>> getHistory() async {
    // cleanEntryBx();
    clearHistoryList();
    final historybox = await Hive.openBox<HistoryModel>(ConstString.historyDb);
    _historylist.addAll(historybox.values);

    return _historylist;
  }

  Future<void> takeHistoryFormCloud(BuildContext context) async {
    try {
      final historybox =
          await Hive.openBox<HistoryModel>(ConstString.historyDb);
      historybox.clear();

      final snapshot = await HistoryController().getAllHistory();
      List<HistoryModel> list =
          snapshot.docs.map((e) => HistoryModel.fromjson(e.data())).toList();
      for (var entry in list) {
        historybox.put(entry.date, entry);
      }
    } catch (e) {
      showCustomeSnackBar(context, 'Error while getting history', true);
    }
  }

  cleanHistory() async {
    final historybox = await Hive.openBox<HistoryModel>(ConstString.historyDb);
    historybox.clear();
  }
}
