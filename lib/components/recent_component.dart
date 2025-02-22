import 'package:budget_tracker_app/controllers/recent_transaction_controller.dart';
import 'package:budget_tracker_app/modal/recent_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentComponent extends StatelessWidget {
  const RecentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    RecentTransactionController rtc = Get.put(RecentTransactionController());
    rtc.fetchRecentTransaction();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GetBuilder<RecentTransactionController>(
            builder: (context) {
              return FutureBuilder<List<RecentModal>>(
                  future: rtc.recentTransaction,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No transactions available.'));
                    }
              
                    List<RecentModal> recentTransaction = snapshot.data!;
                    return ListView.builder(
                      itemCount: recentTransaction.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExpansionTile(
                          title: Text("${recentTransaction[index].description}"),
                          subtitle: Text("${recentTransaction[index].date}"),
                          children: [
                            ListTile(
                              title: Text("${recentTransaction[index].mode}"),
                              subtitle: Text("${recentTransaction[index].type}"),
                              trailing: Text("${recentTransaction[index].amount}"),
                            ),
                          ],
                        );
                      },
                    );
                  });
            }
          ),
        ),
      ],
    );
  }
}
