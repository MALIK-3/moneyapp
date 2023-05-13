import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money_management_flutter/db/dashboard/dashboard_db.dart';
import 'package:money_management_flutter/models/dashboard/dashboard_model.dart';
import 'package:money_management_flutter/models/transaction/transaction_model.dart';

import '../../../db/category/category_db.dart';
import '../../../db/transaction/transaction_db.dart';
import '../../../models/category/category_model.dart';

class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  // CategoryType? _selectedCategorytype;

  // TransactionModel? _selectedAmount;

  // final _amountListnable = DashboardDB.instance.AmountNotifier;

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              color: Colors.green,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ValueListenableBuilder(
                    valueListenable: DashboardDB.instance.AmountNotifier,
                    builder: (BuildContext ctx, List<DashboardModel> newList,
                        Widget? _) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${newList.length}',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '1000 INR',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.red,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'EXPENSE',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '500 INR',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'BALANACE',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1500 INR',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> addAmtList() async {
  //   final _dbModel = DashboardModel(
  //     type: _selectedCategorytype!,
  //     amount: _selectedAmount!,
  //   );

  //   await DashboardDB.instance.addAmtList(_dbModel);
  //   DashboardDB.instance.refresh();
  // }

  // dbAmoutList() {
  //   final _value = List<DashboardModel>;
  //   return _value.toString();
  // }
}
