import 'package:budget_tracker_app/controllers/expense_controller.dart';
import 'package:budget_tracker_app/controllers/income_controller.dart';
import 'package:budget_tracker_app/modal/expense_modal.dart';
import 'package:budget_tracker_app/modal/income_modal.dart';
import 'package:get/get.dart';

class OverallController extends GetxController {
  RxInt componentIndex = 0.obs;

  num totalExpensesSum = 0;
  num totalIncomeSum = 0;
  num totalProfit = 0;
  bool? isExpense;
  bool isupdated = false;
  ExpenseController controller = Get.put(ExpenseController());
  IncomeController ic = Get.put(IncomeController());
  int? recentId;

  void getBudget(bool name) {
    isExpense = name;
    update();
  }

  Future<void> getExpenses() async {
    controller.fetchExpenses();
    List<ExpenseModal>? expenses = await controller.addedExpenses;
    totalExpensesSum = 0;
    for (int i = 0; i < expenses!.length; i++) {
      totalExpensesSum += expenses[i].amount!;
      update();
    }
  }

  Future<void> getIncome() async {
    ic.fetchIncome();
    List<IncomeModal>? income = await ic.addedIncome;
    totalIncomeSum = 0;
    for (int i = 0; i < income!.length; i++) {
      totalIncomeSum += income[i].amount!;
      update();
    }
  }

  void getProfit() {
    totalProfit = totalIncomeSum - totalExpensesSum;
    update();
  }

  void getUpdated() {
    isupdated = !isupdated;
    update();
  }

  void getRecentId(int id)
  {
    recentId = id;
    update();
  }
}
