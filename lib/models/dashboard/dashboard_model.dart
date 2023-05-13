import 'dart:ffi';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_flutter/models/transaction/transaction_model.dart';

import '../category/category_model.dart';
part 'dashboard_model.g.dart';

@HiveType(typeId: 4)
class DashboardModel {
  @HiveField(0)
  final CategoryType type;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  String? id;

  DashboardModel({
    required this.type,
    required this.amount,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
