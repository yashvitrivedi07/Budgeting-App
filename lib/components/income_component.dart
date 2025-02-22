import 'package:budget_tracker_app/controllers/income_controller.dart';
import 'package:budget_tracker_app/controllers/overall_controller.dart';
import 'package:budget_tracker_app/modal/income_modal.dart';
import 'package:budget_tracker_app/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeComponent extends StatelessWidget {
  const IncomeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    IncomeController controller = Get.put(IncomeController());
        OverallController oc = Get.put(OverallController());

    controller.fetchIncome();

    return Column(
      children: [
        Expanded(
          child: GetBuilder<IncomeController>(
            builder: (context) {
              return FutureBuilder(
                future: controller.addedIncome,
                builder: (context, snapshot) {
                  List<IncomeModal> incomes = snapshot.data ?? [];
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        
                        return ListTile(
                          onTap: () {
                            oc.getBudget(false);
                            Get.to(DetailScreen(),arguments: incomes[index]);
                          },
                          title: Text("${incomes[index].description}"),
                          subtitle: Text("${incomes[index].date}"),
                          trailing: Text("${incomes[index].amount}"),
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
