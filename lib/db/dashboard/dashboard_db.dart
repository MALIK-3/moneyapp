import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_flutter/models/category/category_model.dart';

import '../../models/dashboard/dashboard_model.dart';
import '../../models/transaction/transaction_model.dart';

const DASHBOARD_DB_NAME = 'dashborad-database';

abstract class DashboardDbFunctions {
  Future<void> addAmtList(DashboardModel odj);
  Future<List<DashboardModel>> listAllTrasactions();
  // Future<void> incomeAmt(CategoryType type);
  // Future<void> expenseAmt(CategoryType type);
}

class DashboardDB implements DashboardDbFunctions {
  DashboardDB._internal();

  static DashboardDB instance = DashboardDB._internal();

  factory DashboardDB() {
    return instance;
  }

  ValueNotifier<List<DashboardModel>> AmountNotifier = ValueNotifier([]);

  ValueNotifier<List<CategoryModel>> incomeAmountListListner =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseAmountListListner =
      ValueNotifier([]);

  @override
  Future<void> addAmtList(DashboardModel obj) async {
    final _db = await Hive.openBox<DashboardModel>(DASHBOARD_DB_NAME);
    await _db.put(obj.id, obj);
  }

  @override
  Future<List<DashboardModel>> listAllTrasactions() async {
    final _dashDB = await Hive.openBox<DashboardModel>(DASHBOARD_DB_NAME);
    return _dashDB.values.toList();
  }

  Future<void> refresh() async {
    final _list = await listAllTrasactions();
    AmountNotifier.value.clear();
    AmountNotifier.value.addAll(_list);

    await Future.forEach(
      _list,
      (DashboardModel dashboardAmt) {
        if (dashboardAmt.type == CategoryType.income) {
          List<double> _incomeAmount = [dashboardAmt.amount];
          double _sumIncome = _incomeAmount.fold(0, (acc, val) => acc + val);
          // double _sumIncome = _incomeAmount.fold(0, (acc, val) => acc + val);
          // print(_incomeAmount.fold(0, (acc, val) => acc + val));
        } else {
          List<double> _expenseAmount = [dashboardAmt.amount];
          // double _expSum = _expenseAmount.fold(0, (acc, val) => acc + val);
          // print(_expSum);
        }
      },
    );

    AmountNotifier.notifyListeners();

    // incomeAmountListListner.value.clear();
    // expenseAmountListListner.value.clear();

    // await Future.forEach(
    //   _list,
    //   (DashboardModel amtCategory) {
    //     if (amtCategory.type == CategoryType.income) {
    //       incomeAmountListListner.value.add(amtCategory as CategoryModel);
    //     } else {
    //       expenseAmountListListner.value.add(amtCategory as CategoryModel);
    //     }
    //   },
    // );
    // incomeAmountListListner.notifyListeners();
    // expenseAmountListListner.notifyListeners();
  }

  // @override
  // Future<void> incomeAmt(CategoryType income) async {
  //   final _db = await Hive.openBox<DashboardModel>(DASHBOARD_DB_NAME);
  //   final _incomeList = _db.values.toList();
  //   _incomeList.addAll(_incomeList);
  //   refresh();
  // }

  // @override
  // Future<void> expenseAmt(CategoryType expense) async {
  //   final _db = await Hive.openBox<DashboardModel>(DASHBOARD_DB_NAME);
  //   final _expenseList = _db.values.toList();
  //   _expenseList.addAll(_expenseList);
  //   refresh();
  // }
}
