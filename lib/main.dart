import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_flutter/models/category/category_model.dart';
import 'package:money_management_flutter/models/dashboard/dashboard_model.dart';
import 'package:money_management_flutter/models/transaction/transaction_model.dart';
import 'package:money_management_flutter/screens/add_transactions/screen_add_transaction.dart';
import 'package:money_management_flutter/screens/home/screen_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  if (!Hive.isAdapterRegistered(DashboardModelAdapter().typeId)) {
    Hive.registerAdapter(DashboardModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreenHome(),
      routes: {
        ScreenaddTransactions.routeName: (ctx) => const ScreenaddTransactions(),
      },
    );
  }
}
