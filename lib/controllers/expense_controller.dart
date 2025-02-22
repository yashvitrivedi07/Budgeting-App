import 'package:budget_tracker_app/helper/data_base_helper.dart';
import 'package:budget_tracker_app/modal/expense_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  // LISTS
  List expenseCategoryImg = [
    "asset/icons/insurance_12139769.png",
    "asset/icons/browser_6629418.png",
    "asset/icons/shopping_3082013.png",
    "asset/icons/debt_9882182.png",
    "asset/icons/cinema_2809591.png",
    "asset/icons/vehicles.png",
    "asset/icons/pets_3460473.png",
    "asset/icons/property_11008561.png",
    "asset/icons/money-saving_16361828.png",
    "asset/icons/building_13561776.png",
    "asset/icons/wallet_1058619.png",
    "asset/icons/rent_11790627.png",
    "asset/icons/subscription_15313590.png",
    "asset/icons/donation_18648516.png",
    "asset/icons/daycare-center_3212953.png",
    "asset/icons/tshirt_4715310.png",
    "asset/icons/healthcare_14597881.png",
    "asset/icons/fuel_13505965.png",
    "asset/icons/healthcare_2382533.png",
    "asset/icons/toiletries_5114447.png",
    "asset/icons/education_3976625 (1).png",
    "asset/icons/electric-tower_9414783.png",
    "asset/icons/inflation_9310772.png",
    "asset/icons/giftbox_1140033.png",
    "asset/icons/layout_9950517.png",
  ];

  List expenseCategory = [
    "Insurance",
    "Utilities",
    "Groceries",
    "Debt",
    "Entertainment",
    "Transportation",
    "Pets",
    "Property taxes",
    "Savings",
    "Housing",
    "Mortgage",
    "Rent",
    "Subscriptions",
    "Charitable giving",
    "Childcare",
    "Clothing",
    "Emergency fund",
    "Gas",
    "Health care",
    "Personal care",
    "Education",
    "Electricity",
    "Food expenses",
    "Gifts",
    "Other"
  ];

  // ATTRIBUTES
  String? mode, date, time, category;
  RxInt categoryImageIndex = 0.obs;
  Future<List<ExpenseModal>>? addedExpenses;
  int? deleteIndex;
  Future<List<ExpenseModal>>? categoryList;

  //METHODS
  Future<void> addExpense(ExpenseModal modal) async {
    int? res = await DataBaseHelper.dbh.insertExpense(modal);

    if (res != null) {
      Get.snackbar("Successfull", "Expense added successfully",
          backgroundColor: Colors.green.shade400);
    } else {
      Get.snackbar("Failed", "Exception", backgroundColor: Colors.red.shade400);
    }
  }

  void getMode(String val) {
    mode = val;
    update();
  }

  void fetchExpenses() async {
    addedExpenses = DataBaseHelper.dbh.fetchExpense();
    update();
  }

  void updateExpenses({required ExpenseModal modal}) async {
    int? res = await DataBaseHelper.dbh.updateExpense(modal);
    if (res != null) {
      fetchExpenses();
      Get.snackbar('Category Updated', "success");
    } else {
      Get.snackbar("error", "update failed");
    }

    update();
  }

  void deleteExpense(int id) async {
    int? res = await DataBaseHelper.dbh.deleteExpense(id);
    if (res != null) {
      Get.back();
      fetchExpenses();
      Get.snackbar("Deleted...", "data has benn deleted...");
    } else {
      Get.snackbar("Error", "Not deleted");
    }
    update();
  }

  void searchCategory(String search) {
    categoryList = DataBaseHelper.dbh.searchCategory(search: search);
    update();
  }
}
