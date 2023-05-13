import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management_flutter/db/category/category_db.dart';
import 'package:money_management_flutter/db/transaction/transaction_db.dart';
import 'package:money_management_flutter/models/category/category_model.dart';

import '../../models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (ctx, index) {
            final _value = newList[index];

            return Slidable(
              key: Key(_value.id!),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (ctx) {
                      TransactionDB.instance.deleteTransaction(_value.id!);
                    },
                    icon: Icons.delete,
                    label: 'Delete',
                  )
                ],
              ),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _value.type == CategoryType.income
                        ? const Color.fromARGB(255, 78, 160, 58)
                        : const Color.fromARGB(255, 199, 42, 42),
                    radius: 40,
                    child: Text(
                      parsedDate(_value.date),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  title: Text('Rs ${_value.amount}'),
                  subtitle: Text(_value.category.name),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(height: 10);
          },
          itemCount: newList.length,
        );
      },
    );
  }

  String parsedDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
    //return '${date.day}\n ${date.month}';
  }
}
