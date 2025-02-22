import 'package:budget_tracker_app/components/bar_chart_component.dart';
import 'package:budget_tracker_app/controllers/expense_controller.dart';
import 'package:budget_tracker_app/controllers/overall_controller.dart';
import 'package:budget_tracker_app/modal/expense_modal.dart';
import 'package:budget_tracker_app/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpenseComponent extends StatelessWidget {
  const ExpenseComponent({super.key});

  @override
  Widget build(BuildContext context) {
    ExpenseController controller = Get.put(ExpenseController());
    OverallController oc = Get.put(OverallController());
    controller.fetchExpenses();

    return Column(
      children: [
        Expanded(
            child: SizedBox(
                height: 200.h,
                width: double.infinity,
                child: BarChartComponent())),
        Expanded(
          child: GetBuilder<ExpenseController>(
            builder: (context) {
              return FutureBuilder(
                future: controller.addedExpenses,
                builder: (context, snapshot) {
                  List<ExpenseModal> expenses = snapshot.data ?? [];
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            oc.getBudget(true);
                            Get.to(DetailScreen(), arguments: expenses[index]);
                          },
                          leading: CircleAvatar(
                            radius: 20.w,
                            child: Image.memory(expenses[index].img!),
                          ),
                          title: Text("${expenses[index].description}"),
                          subtitle: Text("${expenses[index].category}"),
                          trailing: Text("${expenses[index].amount}"),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
