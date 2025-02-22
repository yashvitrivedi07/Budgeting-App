import 'package:budget_tracker_app/helper/data_base_helper.dart';
import 'package:budget_tracker_app/modal/income_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeController extends GetxController {
  String? mode, date, time;
  Future<List<IncomeModal>>? addedIncome;

  Future<void> addIncome(IncomeModal modal) async {
    int? res = await DataBaseHelper.dbh.insertIncome(modal);

    if (res != null) {
      Get.snackbar("Successfull", "Income added successfully",
          backgroundColor: Colors.green.shade400);
    } else {
      Get.snackbar("Failed", "Exception", backgroundColor: Colors.red.shade400);
    }
  }

  void getIncomeMode(String val) {
    mode = val;
    update();
  }

  void fetchIncome() async {
    addedIncome = DataBaseHelper.dbh.fetchIncome();
    update();
  }

  Future<void> deleteIncome(int id) async {
    int? res = await DataBaseHelper.dbh.deleteIncome(id);
    if (res != null) {
      Get.back();
      fetchIncome();
      Get.snackbar("deleted", "ur data has been deleted");
    } else {
      Get.snackbar("error", "Try again");
    }
    update();
  }

  void updateIncome({required IncomeModal modal}) async {
    int? res = await DataBaseHelper.dbh.updateIncome(modal);
    if (res != null) {
      fetchIncome();
      Get.snackbar('income Updated', "success");
    } else {
      Get.snackbar("error", "update failed");
    }

    update();
  }
}
