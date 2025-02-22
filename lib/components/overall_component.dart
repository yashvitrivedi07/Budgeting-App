import 'package:budget_tracker_app/components/expense_component.dart';
import 'package:budget_tracker_app/components/income_component.dart';
import 'package:budget_tracker_app/components/total_budget_component.dart';
import 'package:budget_tracker_app/controllers/overall_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class OverallComponent extends StatelessWidget {
  const OverallComponent({super.key});

  @override
  Widget build(BuildContext context) {
    OverallController controller = Get.put(OverallController());
    List components = [
      ExpenseComponent(),
      IncomeComponent(),
      TotalBudgetComponent()
    ];
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(top: 70, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                ToggleSwitch(
                  cornerRadius: 20,
                  initialLabelIndex: controller.componentIndex.value,
                  totalSwitches: 3,
                  labels: ['Expenses', 'income', 'total'],
                  activeBgColor: [Colors.black],
                  centerText: true,
                  minWidth: 100.w,
                  onToggle: (index) {
                    controller.componentIndex.value = index!;
                  },
                ),
              ],
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(top: 50),
              child: components[controller.componentIndex.value],
            )),
            SizedBox()
          ],
        ),
      );
    });
  }
}

/**
 * 
 * 
 */
