import 'package:budget_tracker_app/controllers/expense_controller.dart';
import 'package:budget_tracker_app/controllers/income_controller.dart';
import 'package:budget_tracker_app/controllers/recent_transaction_controller.dart';
import 'package:budget_tracker_app/modal/expense_modal.dart';
import 'package:budget_tracker_app/modal/income_modal.dart';
import 'package:budget_tracker_app/modal/recent_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddComponent extends StatelessWidget {
  const AddComponent({super.key});

  @override
  Widget build(BuildContext context) {
    //key
    // total

    //EXPENSES
    ExpenseController controller = Get.put(ExpenseController());
    TextEditingController descController = TextEditingController();
    TextEditingController amtController = TextEditingController();
    TextEditingController searchController = TextEditingController();

    // INCOME
    TextEditingController incomeDescController = TextEditingController();
    TextEditingController incomeAmtController = TextEditingController();
    IncomeController incomeController = Get.put(IncomeController());

    RecentTransactionController rtc = Get.put(RecentTransactionController());
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                showBottomSheet(
                  sheetAnimationStyle: AnimationStyle(
                      curve: Curves.decelerate, duration: Duration(seconds: 1)),
                  enableDrag: true,
                  showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 550.h,
                      width: 350.w,
                      child: BottomSheet(
                        shadowColor: Colors.grey.shade400,
                        backgroundColor: Colors.white,
                        enableDrag: true,
                        onClosing: () {},
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 15),
                                  child: Text(
                                    "Expense : ",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                                //DESCRIPTION
                                TextFormField(
                                  autocorrect: true,
                                  maxLines: 2,
                                  controller: descController,
                                  decoration: InputDecoration(
                                      hintText: "Enter Description",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),

                                //AMOUNT
                                TextFormField(
                                  controller: amtController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "Amount",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),

                                //CATEGORY
                                Row(
                                  children: [
                                    Text(
                                      "Category",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Get.bottomSheet(
                                            backgroundColor: Colors.white,
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "Categories :",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextField(
                                                      controller:
                                                          searchController,
                                                      decoration:
                                                          InputDecoration(
                                                              suffixIcon:
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .searchCategory(searchController.text);
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .search)),
                                                              hintText:
                                                                  "Search category",
                                                              border:
                                                                  OutlineInputBorder()),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: GridView.builder(
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                      ),
                                                      itemCount: controller
                                                          .expenseCategory
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Obx(() {
                                                          return InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .categoryImageIndex
                                                                  .value = index;
                                                              controller
                                                                      .category =
                                                                  controller
                                                                          .expenseCategory[
                                                                      index];
                                                            },
                                                            child: Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                height: 50.h,
                                                                width: 50.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border: Border
                                                                            .all(
                                                                                // ignore: unrelated_type_equality_checks
                                                                                color: (controller.categoryImageIndex == index)
                                                                                    ? Colors
                                                                                        .grey
                                                                                    : Colors
                                                                                        .transparent),
                                                                        color: Colors
                                                                            .white,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              blurRadius: 2,
                                                                              color: Colors.grey.shade400)
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(15)),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Image.asset(
                                                                      '${controller.expenseCategoryImg[index]}',
                                                                      height:
                                                                          40.h,
                                                                      width:
                                                                          40.w,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    Text(
                                                                      "${controller.expenseCategory[index]}",
                                                                      maxLines:
                                                                          2,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
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
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ))
                                                ]),
                                          );
                                        },
                                        icon: Icon(Icons.category)),
                                    Text("${controller.category}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),

                                // MODE
                                Row(
                                  children: [
                                    Text(
                                      "Mode",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: GetBuilder<ExpenseController>(
                                          builder: (context) {
                                        return DropdownButton(
                                          value: controller.mode,
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
                                            controller.getMode(value!);
                                          },
                                        );
                                      }),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),

                                // DATE
                                Row(
                                  children: [
                                    Text(
                                      "Date",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GetBuilder<ExpenseController>(builder: (c) {
                                      return IconButton(
                                          onPressed: () async {
                                            DateTime? date =
                                                await showDatePicker(
                                              context: context,
                                              firstDate: DateTime(2020),
                                              lastDate: DateTime(2070),
                                              initialDate: DateTime.now(),
                                              keyboardType:
                                                  TextInputType.datetime,
                                              barrierColor: Colors.transparent,
                                              barrierDismissible: true,
                                            );

                                            controller.date =
                                                "${date?.day}/${date?.month}/${date?.year}"
                                                    .padLeft(2, '0');
                                          },
                                          icon: Icon(Icons.calendar_month));
                                    }),
                                    Text("${controller.date}")
                                  ],
                                ),

                                // Add expense
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 50.h,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.red),
                                        ),
                                        onPressed: () async {
                                          Get.back();

                                          DateTime time = DateTime.now();
                                          int amt =
                                              int.parse(amtController.text);

                                          String imgPath =
                                              controller.expenseCategoryImg[
                                                  controller.categoryImageIndex
                                                      .value];
                                          ByteData data =
                                              await rootBundle.load(imgPath);

                                          Uint8List image =
                                              data.buffer.asUint8List();

                                          ExpenseModal modal = ExpenseModal(
                                              amount: amt,
                                              category: controller.category,
                                              date: controller.date,
                                              description: descController.text,
                                              id: 0,
                                              mode: controller.mode,
                                              time:
                                                  "${time.hour}:${time.minute}",
                                              img: image);

                                          if (modal.amount != null &&
                                              modal.category != null &&
                                              modal.date != null &&
                                              modal.description != null &&
                                              modal.mode != null) {
                                            controller.addExpense(modal);
                                          } else {
                                            Get.snackbar("REquired",
                                                "All detail required",
                                                backgroundColor: Colors.red);
                                          }

                                          RecentModal tm = RecentModal(
                                              amount: modal.amount,
                                              date: modal.date,
                                              description: modal.description,
                                              id: modal.id,
                                              mode: modal.mode,
                                              time: modal.time,
                                              type: "Expense");

                                          rtc.addRecentTransaction(tm);

                                          descController.clear();
                                          amtController.clear();
                                          controller.category = null;
                                          controller.categoryImageIndex.value = 0;
                                          controller.date = null;
                                          controller.time = null;
                                          controller.mode = null;
                                        },
                                        child: Text(
                                          "Add Expense",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );

                // CATEGORY BOTTOM SHEET
              },
              child: Container(
                height: 140.h,
                width: 160.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'asset/icons/expense.png',
                      height: 70.h,
                      width: 70.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Expenses",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //   INCOME INCOME INCOME INCOME INCOME INCOME INCOME INCOME INCOME INCOME INCOME INCOME
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                showBottomSheet(
                  sheetAnimationStyle: AnimationStyle(
                      curve: Curves.decelerate, duration: Duration(seconds: 1)),
                  enableDrag: true,
                  showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 550.h,
                      width: 350.w,
                      child: BottomSheet(
                        shadowColor: Colors.grey.shade400,
                        backgroundColor: Colors.white,
                        onClosing: () {},
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 15),
                                  child: Text(
                                    "Income : ",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                                //DESCRIPTION
                                TextField(
                                  maxLines: 2,
                                  controller: incomeDescController,
                                  decoration: InputDecoration(
                                      hintText: "Enter Description",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),

                                //AMOUNT
                                TextField(
                                  controller: incomeAmtController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "Amount",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),

                                // MODE
                                Row(
                                  children: [
                                    Text(
                                      "Mode",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: GetBuilder<IncomeController>(
                                          builder: (context) {
                                        return DropdownButton(
                                          value: incomeController.mode,
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
                                            incomeController
                                                .getIncomeMode(value!);
                                          },
                                        );
                                      }),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),

                                // DATE
                                Row(
                                  children: [
                                    Text(
                                      "Date",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GetBuilder<IncomeController>(builder: (c) {
                                      return IconButton(
                                          onPressed: () async {
                                            DateTime? date =
                                                await showDatePicker(
                                              context: context,
                                              firstDate: DateTime(2020),
                                              lastDate: DateTime(2070),
                                              initialDate: DateTime.now(),
                                              keyboardType:
                                                  TextInputType.datetime,
                                              barrierColor: Colors.transparent,
                                              barrierDismissible: true,
                                            );

                                            incomeController.date =
                                                "${date?.day}/${date?.month}/${date?.year}"
                                                    .padLeft(2, '0');
                                          },
                                          icon: Icon(Icons.calendar_month));
                                    }),
                                    Text("${incomeController.date}")
                                  ],
                                ),

                                // Add INCOME
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 50.h,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.green),
                                        ),
                                        onPressed: () async {
                                          Get.back();
                                          DateTime time = DateTime.now();
                                          int amt = int.parse(
                                              incomeAmtController.text);

                                          // INCOME
                                          IncomeModal im = IncomeModal(
                                            amount: amt,
                                            date: incomeController.date,
                                            description:
                                                incomeDescController.text,
                                            id: 0,
                                            mode: incomeController.mode,
                                            time: "${time.hour}:${time.minute}",
                                          );

                                          if (im.amount != null &&
                                              im.date != null &&
                                              im.description != null &&
                                              im.mode != null &&
                                              im.time != null) {
                                            incomeController.addIncome(im);
                                          } else {
                                            Get.snackbar("REquired",
                                                "All detail required",
                                                backgroundColor: Colors.red);
                                          }

                                          // RECENT

                                          RecentModal tm = RecentModal(
                                              amount: im.amount,
                                              date: im.date,
                                              description: im.description,
                                              id: im.id,
                                              mode: im.mode,
                                              time: im.time,
                                              type: "Income");
                                          rtc.addRecentTransaction(tm);

                                          incomeAmtController.clear();
                                          incomeDescController.clear();
                                          incomeController.date = null;
                                          incomeController.mode = null;
                                          incomeController.time = null;
                                        },
                                        child: Text(
                                          "Add Income",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 140.h,
                width: 160.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'asset/icons/profits.png',
                      height: 70.h,
                      width: 70.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Top-Up",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
