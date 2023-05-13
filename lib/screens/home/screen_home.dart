import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money_management_flutter/screens/add_transactions/screen_add_transaction.dart';
import 'package:money_management_flutter/screens/category/category_add_popup.dart';
import 'package:money_management_flutter/screens/category/screen_category.dart';
import 'package:money_management_flutter/screens/home/dashboard/screen_dashboard.dart';
import 'package:money_management_flutter/screens/home/widgets/bottom_navigation.dart';
import 'package:money_management_flutter/screens/transactions/screen_transactions.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
    ScreenDashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        title: const Text('MONEY MANAGER'),
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, child_) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('button Transaction');
            Navigator.of(context).pushNamed(ScreenaddTransactions.routeName);
          } else {
            print('button Category');
            showCategoryAddPopup(context);
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
