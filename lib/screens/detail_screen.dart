import 'package:budget_tracker_app/components/update/expense_component.dart';
import 'package:budget_tracker_app/components/update/income_component.dart';
import 'package:budget_tracker_app/controllers/overall_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OverallController oc = Get.put(OverallController());
    var data = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("EXTRA"),
        ),
        body: (oc.isExpense == false)
            ? UpdateIncome()
            : UpdateExpense(
                data: data,
              ));
  }
}
