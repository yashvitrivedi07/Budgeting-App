import 'dart:developer';

import 'package:budget_tracker_app/controllers/expense_controller.dart';
import 'package:budget_tracker_app/controllers/overall_controller.dart';
import 'package:budget_tracker_app/controllers/recent_transaction_controller.dart';
import 'package:budget_tracker_app/modal/expense_modal.dart';
import 'package:budget_tracker_app/modal/recent_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateExpense extends StatelessWidget {
  final ExpenseModal data;
  const UpdateExpense({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    log("Updated Data: ${data.description}");
    log("Updated Data: ${data.amount}");
    log("Updated Data: ${data.category}");
    log("Updated Data: ${data.date}");
    // log("Updated Data: ${data.img}");
    log("Updated Data: ${data.mode}");
    log("Updated Data: ${data.time}");
    ExpenseController expenses = Get.put(ExpenseController());
    OverallController oc = Get.put(OverallController());

    TextEditingController uSearchController = TextEditingController();

    //CONTROLLERS
    TextEditingController uDesc = TextEditingController();
    TextEditingController uAmt = TextEditingController();
    RecentTransactionController rtc = Get.put(RecentTransactionController());

    uDesc.text = data.description!;
    uAmt.text = data.amount.toString();

    return Center(child: GetBuilder<OverallController>(builder: (c) {
      return GetBuilder<ExpenseController>(builder: (ct) {
        return SingleChildScrollView(
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
                            controller: uDesc,
                            decoration:
                                InputDecoration(hintText: "Description.."),
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
                            controller: uAmt,
                            decoration: InputDecoration(hintText: "AMOUNT"),
                          )),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          child: Text("${data.category}"),
                        )
                      : InkWell(
                          onTap: () {
                            Get.bottomSheet(
                              backgroundColor: Colors.white,
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "Categories :",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: uSearchController,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  expenses.searchCategory(
                                                      uSearchController.text);
                                                },
                                                icon: Icon(Icons.search)),
                                            hintText: "Search category",
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                    Expanded(
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                        ),
                                        itemCount:
                                            expenses.expenseCategory.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Obx(() {
                                            return InkWell(
                                              onTap: () {
                                                expenses.categoryImageIndex
                                                    .value = index;
                                                expenses.category = expenses
                                                    .expenseCategory[index];
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  height: 50.h,
                                                  width: 50.w,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          // ignore: unrelated_type_equality_checks
                                                          color: (expenses
                                                                      // ignore: unrelated_type_equality_checks
                                                                      .categoryImageIndex ==
                                                                  index)
                                                              ? Colors.grey
                                                              : Colors
                                                                  .transparent),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 2,
                                                            color: Colors
                                                                .grey.shade400)
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        '${expenses.expenseCategoryImg[index]}',
                                                        height: 40.h,
                                                        width: 40.w,
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      Text(
                                                        "${expenses.expenseCategory[index]}",
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    ],
                                                  )),
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Colors.pink)),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          "Select Category",
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ]),
                            );
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
                            child: Text("${data.category}"),
                          ),
                        ),
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
                          child: Text("${data.mode}"),
                        )
                      : InkWell(
                          onTap: () {},
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
                                    color: Colors.grey.shade400, blurRadius: 5)
                              ],
                            ),
                            child: DropdownButton(
                              value: expenses.mode,
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
                                expenses.getMode(value!);
                              },
                            ),
                          ),
                        )
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

                            expenses.date =
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
                  )
                ],
              ),

              SizedBox(
                height: 10.h,
              ),

              // UPDATE EXPENSE    UPDATE EXPENSE    UPDATE EXPENSE    UPDATE EXPENSE

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

                  GetBuilder<OverallController>(
                    builder: (controller) {
                      return controller.isupdated
                          ? ElevatedButton(
                              onPressed: () async {
                                oc.getUpdated();
                                data.description = uDesc.text;
                                data.amount = int.parse(uAmt.text);
                                if (expenses.category != null &&
                                    expenses.date != null &&
                                    expenses.mode != null) {
                                  data.date = expenses.date;
                                  data.mode = expenses.mode;
                                  data.category = expenses.category;
                                }

                                TimeOfDay timeeee = TimeOfDay.now();
                                data.time = "${timeeee.hour}:${timeeee.minute}";

                                String imgPath = expenses.expenseCategoryImg[
                                    expenses.categoryImageIndex.value];

                                ByteData d = await rootBundle.load(imgPath);

                                Uint8List image = d.buffer.asUint8List();

                                data.img = image;

                                ExpenseModal modal = ExpenseModal(
                                  id: data.id,
                                  amount: data.amount,
                                  category: data.category,
                                  date: data.date,
                                  description: data.description,
                                  img: data.img,
                                  mode: data.mode,
                                  time: data.time,
                                );

                                RecentModal rm = RecentModal(
                                    amount: modal.id,
                                    date: modal.date,
                                    description: modal.description,
                                    id: modal.id,
                                    mode: modal.mode,
                                    time: modal.time,
                                    type: "Expense");

                                expenses.updateExpenses(modal: modal);
                                rtc.updateRecentTransaction(rm);
                              },
                              child: Text("Update"),
                            )
                          : SizedBox();
                    },
                  ),

                  // DELETE EXPENSE
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
                                  expenses.deleteExpense(data.id!);
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
