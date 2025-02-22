import 'package:budget_tracker_app/controllers/income_controller.dart';
import 'package:budget_tracker_app/controllers/overall_controller.dart';
import 'package:budget_tracker_app/controllers/recent_transaction_controller.dart';
import 'package:budget_tracker_app/modal/income_modal.dart';
import 'package:budget_tracker_app/modal/recent_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateIncome extends StatelessWidget {
  const UpdateIncome({super.key});

  @override
  Widget build(BuildContext context) {
    IncomeController income = Get.put(IncomeController());
    OverallController oc = Get.put(OverallController());

    // ARGUMENT
    IncomeModal data = Get.arguments;

    //CONTROLLERS
    TextEditingController uDescIncomeController = TextEditingController();
    TextEditingController uAMtIncomeController = TextEditingController();

    uDescIncomeController.text = data.description!;
    RecentTransactionController rtc = Get.put(RecentTransactionController());

    uAMtIncomeController.text = data.amount.toString();
    return Center(child: GetBuilder<OverallController>(builder: (c) {
      return GetBuilder<IncomeController>(builder: (ct) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "DESCRIPTION : ",
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 5)
                    ]),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (oc.isupdated == false)
                        ? Text("${data.description}")
                        : TextField(
                            controller: uDescIncomeController,
                            decoration:
                                InputDecoration(hintText: "Description"),
                          )),
              ),

              SizedBox(
                height: 10.h,
              ),

              // amt

              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "AMOUNT : ",
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 5)
                    ]),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (oc.isupdated == false)
                        ? Text(
                            "${data.amount}",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        : TextField(
                            controller: uAMtIncomeController,
                            decoration: InputDecoration(hintText: "Amount"),
                          )),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(15),
                      height: 70.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade400, blurRadius: 5)
                          ]),
                      child: (oc.isupdated == false)
                          ? Text("${data.mode}")
                          : DropdownButton(
                              value: income.mode,
                              autofocus: false,
                              items: [
                                DropdownMenuItem(
                                  value: "cash",
                                  child: Text("Cash"),
                                ),
                                DropdownMenuItem(
                                  value: "online",
                                  child: Text("Online"),
                                ),
                              ],
                              onChanged: (value) {
                                income.getIncomeMode(value!);
                              },
                            )),
                ],
              ),

              SizedBox(
                height: 10.h,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (oc.isupdated == false)
                      ? Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.all(15),
                          height: 70.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade400, blurRadius: 5)
                              ]),
                          child: Text("${data.date}"),
                        )
                      : InkWell(
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2070),
                              initialDate: DateTime.now(),
                              keyboardType: TextInputType.datetime,
                              barrierColor: Colors.transparent,
                              barrierDismissible: true,
                            );

                            income.date =
                                "${date?.day}/${date?.month}/${date?.year}"
                                    .padLeft(2, '0');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.all(15),
                            height: 70.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade400,
                                      blurRadius: 5)
                                ]),
                            child: Text("${data.date}"),
                          ),
                        ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(15),
                    height: 70.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade400, blurRadius: 5)
                        ]),
                    child: Text("${data.time}"),
                  ),
                ],
              ),

              SizedBox(
                height: 10.h,
              ),

              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        oc.getUpdated();
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      )),
                  (oc.isupdated == true)
                      ? ElevatedButton(
                          onPressed: () {
                            oc.getUpdated();
                            TimeOfDay t = TimeOfDay.now();
                            data.amount = int.parse(uAMtIncomeController.text);
                            data.description = uDescIncomeController.text;
                            data.date = income.date;
                            data.mode = income.mode;
                            data.time = "${t.hour / t.minute}";

                            IncomeModal modal = IncomeModal(
                                amount: data.amount,
                                id: data.id,
                                date: data.date,
                                description: data.description,
                                mode: data.mode,
                                time: data.time);
                            
                            RecentModal rm = RecentModal(
                              amount: data.amount,
                              date: data.date,
                              description: data.description,
                              id: data.id,
                              mode: data.mode,
                              time: data.time,
                              type: "Income"
                            );
                            income.updateIncome(modal: modal);
                            rtc.updateRecentTransaction(rm);
                          },
                          child: Text("Update"))
                      : Container(),
                  IconButton(
                      onPressed: () {
                        Get.dialog(AlertDialog(
                          title: Text("DELETE"),
                          content: Text("Are you sure !! wanna delete this"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel")),
                            ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                  income.deleteIncome(data.id!);
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                )),
                          ],
                        ));
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
            ],
          ),
        );
      });
    }));
  }
}
