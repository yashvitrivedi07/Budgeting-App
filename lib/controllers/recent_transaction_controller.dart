import 'package:budget_tracker_app/helper/data_base_helper.dart';
import 'package:budget_tracker_app/modal/recent_modal.dart';
import 'package:get/get.dart';

class RecentTransactionController extends GetxController {
  Future<List<RecentModal>>? recentTransaction;

  Future<void> addRecentTransaction(RecentModal modal) async {
    int? res = await DataBaseHelper.dbh.insertRecentTransaction(modal);

    if (res != null) {
      Get.snackbar("", "");
    } else {
      Get.snackbar("Not Added", "");
    }
    update();
  }

  fetchRecentTransaction() {
    recentTransaction = DataBaseHelper.dbh.fetchRecentData();
    update();
  }

  updateRecentTransaction(RecentModal modal) async {
    int? res = await DataBaseHelper.dbh.updateRecentTransaction(modal);
    if (res != null) {
      fetchRecentTransaction();
      Get.snackbar('Category Updated', "success");
    } else {
      Get.snackbar("error", "update failed");
    }

    update();
  }
}
