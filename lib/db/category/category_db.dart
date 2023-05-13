import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDB implements CategoryDbFunctions {
  // Making CategoryDB a Single Ton method
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListner =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListner =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategory = await getCategories();
    incomeCategoryListListner.value.clear();
    expenseCategoryListListner.value.clear();

    await Future.forEach(
      _allCategory,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListListner.value.add(category);
        } else {
          expenseCategoryListListner.value.add(category);
        }
      },
    );
    incomeCategoryListListner.notifyListeners();
    expenseCategoryListListner.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(categoryID);
    refreshUI();
  }
}
