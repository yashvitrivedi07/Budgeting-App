import 'package:budget_tracker_app/controllers/expense_controller.dart';
import 'package:budget_tracker_app/modal/expense_modal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class BarChartComponent extends StatelessWidget {
  const BarChartComponent({super.key});

  @override
  Widget build(BuildContext context) {
    ExpenseController controller = Get.put(ExpenseController());
    controller.fetchExpenses();

    return GetBuilder<ExpenseController>(
      builder: (context) {
        return FutureBuilder(
          future: controller.addedExpenses,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ExpenseModal> expenses = snapshot.data ?? [];

              Map<String, double> groupedExpenses = {};
              Map<String, Color> categoryColors = {}; 
              List<String> orderedKeys = []; 

              for (var expense in expenses) {
                String key = "${expense.date}|${expense.category}"; 
                if (!groupedExpenses.containsKey(key)) {
                  orderedKeys.add(key);
                }
                groupedExpenses[key] = (groupedExpenses[key] ?? 0) + expense.amount!;

                // Assign a color to each category
                if (!categoryColors.containsKey(expense.category)) {
                  categoryColors[expense.category!] =
                      Colors.primaries[categoryColors.length % Colors.primaries.length];
                }
              }

              orderedKeys.sort((a, b) {
                DateTime dateA = DateFormat('dd/MM/yyyy').parse(a.split("|")[0]);
                DateTime dateB = DateFormat('dd/MM/yyyy').parse(b.split("|")[0]);
                return dateA.compareTo(dateB);
              });

              List<BarChartGroupData> barGroups = [];
              for (int i = 0; i < orderedKeys.length; i++) {
                String key = orderedKeys[i];
                List<String> parts = key.split("|");
                String category = parts[1];
                double totalAmount = groupedExpenses[key]!;

                barGroups.add(
                  BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: totalAmount,
                        color: categoryColors[category], 
                        width: 20.w,
                        borderRadius: BorderRadius.circular(4.r),
                      )
                    ],
                  ),
                );
              }

              return Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: BarChart(
                  BarChartData(
                    barGroups: barGroups,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() >= orderedKeys.length) {
                              return const SizedBox();
                            }
                            List<String> parts = orderedKeys[value.toInt()].split("|");
                            DateTime date = DateFormat('dd/MM/yyyy').parse(parts[0]);
                            String formattedDate = DateFormat('MMM/dd/yyyy').format(date);
                            return Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Text(
                                formattedDate,
                                style: TextStyle(fontSize: 10.sp),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          if (groupIndex >= orderedKeys.length) return null;

                          List<String> parts = orderedKeys[group.x.toInt()].split("|");
                          String category = parts[1];
                          double amount = rod.toY;

                          return BarTooltipItem(
                            "$category\n₹${amount.toStringAsFixed(2)}",
                            TextStyle(color: Colors.white, fontSize: 12.sp),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
