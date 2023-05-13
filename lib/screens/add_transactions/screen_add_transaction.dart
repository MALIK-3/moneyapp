import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money_management_flutter/db/category/category_db.dart';
import 'package:money_management_flutter/db/dashboard/dashboard_db.dart';
import 'package:money_management_flutter/db/transaction/transaction_db.dart';
import 'package:money_management_flutter/models/category/category_model.dart';
import 'package:money_management_flutter/models/dashboard/dashboard_model.dart';
import 'package:money_management_flutter/models/transaction/transaction_model.dart';

class ScreenaddTransactions extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenaddTransactions({super.key});

  @override
  State<ScreenaddTransactions> createState() => _ScreenaddTransactionsState();
}

class _ScreenaddTransactionsState extends State<ScreenaddTransactions> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Purpose
              TextFormField(
                controller: _purposeTextEditingController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Purpose',
                ),
              ),
              // Amount
              TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Amount',
                ),
              ),
              // Calendar

              TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    print(_selectedDateTemp.toString());
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? 'Select Date'
                    : _selectedDate!.toString()),
              ),

              // Category
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.income;
                            _categoryID = null;
                          });
                        },
                      ),
                      const Text('Income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.expense;
                            _categoryID = null;
                          });
                        },
                      ),
                      const Text('Expense'),
                    ],
                  ),
                ],
              ),
              // Selector Category
              DropdownButton(
                hint: const Text('Select Category'),
                value: _categoryID,
                items: (_selectedCategorytype == CategoryType.income
                        ? CategoryDB().incomeCategoryListListner
                        : CategoryDB().expenseCategoryListListner)
                    .value
                    .map(
                  (e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        _selectedCategoryModel = e;
                      },
                    );
                  },
                ).toList(),
                onChanged: (selectedValue) {
                  print(selectedValue);
                  setState(() {
                    _categoryID = selectedValue;
                  });
                },
              ),
              // Submit
              ElevatedButton(
                onPressed: () {
                  addTransaction();
                  addAmtList();
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;

    if (_purposeText.isEmpty) {
      return;
    }

    if (_amountText.isEmpty) {
      return;
    }

    // if (_categoryID == null) {
    //   return;
    // }

    if (_selectedDate == null) {
      return;
    }

    if (_selectedCategoryModel == null) {
      return;
    }

    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }

    //_selectDate
    //_categoryID
    //_selectCategoryType

    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCategorytype!,
      category: _selectedCategoryModel!,
    );

    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }

  Future<void> addAmtList() async {
    final _amountText = _amountTextEditingController.text;

    if (_amountText.isEmpty) {
      return;
    }

    final _parsedDBAmount = double.tryParse(_amountText);
    if (_parsedDBAmount == null) {
      return;
    }

    final _dbmodel = DashboardModel(
      type: _selectedCategorytype!,
      amount: _parsedDBAmount,
    );

    await DashboardDB.instance.addAmtList(_dbmodel);
    DashboardDB.instance.refresh();
  }
}
